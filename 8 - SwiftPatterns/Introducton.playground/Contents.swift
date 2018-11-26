import Cocoa

protocol BasicProtocol {}

protocol ComplexProtocol: BasicProtocol {}

//class MyClass: MySuperClass, BasicProtocol {}
//
//struct MyStruct: AnotherProtocol {}

protocol Incrementing {
    func increment() -> Int
}

struct Counter: Incrementing {
    private var value: Int = 0

    func increment() -> Int {
//        value += 1
        return value
    }
}
//var counter = Counter()
//counter.increment()
//counter.increment()
