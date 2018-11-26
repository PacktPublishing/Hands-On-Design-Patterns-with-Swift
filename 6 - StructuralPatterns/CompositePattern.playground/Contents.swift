import Cocoa

var str = "Hello, playground"

typealias TestImplementation = () throws -> Void

protocol Testable {
    func run() throws
}

class UnitTest: Testable {
    let name: String
    private let block: TestImplementation
    init(name: String, block: @escaping TestImplementation) {
        self.name = name
        self.block = block
    }

    func run() throws {
        try self.block()
        print("UnitTest \(name) ran successfully")
    }
}

class TestSuite: Testable {
    let name: String
    private(set) var testables: [Testable]
    init(name: String, _ testables: [Testable] = []) {
        self.name = name
        self.testables = testables
    }

    func add(_ testable: Testable) {
        testables.append(testable)
    }

    func run() throws {
        print("Suite \(name) started")
        let errors = testables.compactMap { (testable) -> Error? in
            do {
                try testable.run()
            } catch let e {
                return e
            }
            return nil
        }
        if errors.count > 0 {
            throw Errors(errors: errors)
        }
        print("Suite \(name) ran successfully")
    }

    struct Errors: Error {
        let errors: [Error]
    }
}
let testSuite = TestSuite(name: "Top Level Suite")

testSuite.add(UnitTest(name: "First Test") {})
testSuite.add(UnitTest(name: "Second Test") {})


testSuite.add(
    TestSuite(name: "ChildSuite", [
        UnitTest(name: "Child 1") {},
        UnitTest(name: "Child 2") {}
        ])
)

do {
    try testSuite.run()
} catch let e {
    print(e)
}


func foo() -> String { print("foo"); return "foo" }
func bar() -> String { return "bar" }

(foo(), bar()).1

