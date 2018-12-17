import PlaygroundSupport
import Foundation

private let PREFIX = "MyPrefix"
private func log(_ value: String) {
    print(PREFIX + " " + value)
}

class MyClass {
    func doSomething() {
        log("before")
        /* complex code */
        log("after")
    }
}

MyClass().doSomething()

func logger(prefix: String) -> (String) ->  Void {
    func log(value: String) {
        print(prefix + " " + value)
    }
    return log

}

let logf = logger(prefix: "MyClass")
logf("before")
// do something
logf("after")

