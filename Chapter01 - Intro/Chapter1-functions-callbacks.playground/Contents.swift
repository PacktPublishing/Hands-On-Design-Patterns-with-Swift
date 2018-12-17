import PlaygroundSupport
import Foundation

class MyClass {
    var running = false
    func run() {
        running = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.running = false
        }
    }
}

var instance: MyClass? = MyClass()
instance?.run()
instance = nil

PlaygroundPage.current.needsIndefiniteExecution = true
