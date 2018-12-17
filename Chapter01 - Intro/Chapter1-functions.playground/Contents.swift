import PlaygroundSupport
import Foundation

let runMe = { () -> Int in
    print("run")
    return 0
}
runMe()

class MyClass  {
    var running = false
    lazy var runWithClosure: () -> Void = {
        self.running = true
    }

    func runWithFunction() {
        self.running = true
    }
}
