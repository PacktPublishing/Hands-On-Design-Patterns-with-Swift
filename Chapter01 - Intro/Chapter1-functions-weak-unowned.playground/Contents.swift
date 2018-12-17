import PlaygroundSupport
import Foundation

{
    class MyClass {
        var running = false
        func run() {
            running = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
                self?.running = false
            }
        }
    }
    var instance: MyClass? = MyClass()
    instance?.run()
    instance = nil
}

{
    class MyClass {
        var running = false
        func run() {
            running = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [unowned self] in
                self?.running = false
            }
        }
    }
    var instance: MyClass? = MyClass()
    instance?.run()
    instance = nil
}

PlaygroundPage.current.needsIndefiniteExecution = true
