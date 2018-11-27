import PlaygroundSupport
import Foundation

func logger(prefix: String) -> (String) ->  Void {
    func log(value: String) {
        print(prefix + " " + value)
    }
    return log
}


let log = logger(prefix: "MyClass")

//class MyClass {
//    var running = false
//    func run() {
//
//        running = true
//        log("befre")
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [unowned self] in
//            print("\(self.running)")
//            self.running = false
//        }
//        log("RAN!")
//    }
//}


class MyClass  {
    var running = false
    lazy var runWithClosure: () -> Void = {
        self.running = true
    }

    func runWithFunction() {
        self.running = true
    }
}

var instance: MyClass? = MyClass()
//instance?.run()
instance = nil

PlaygroundPage.current.needsIndefiniteExecution = true

typealias Yolo = (Int, Int)
typealias Yolo2 = (Int, Yolo)

typealias Str = String
Str(format: "%@", arguments: ["Yolo"])

protocol Runnable {
    func run()
}

func concat<T>(a: T, b: T) -> [T] {
    return [a,b]
}

func run<T>(runnable: T) where T: Runnable {
    runnable.run()
}

extension Array: Runnable where Element: Runnable {
    func run() {
        forEach { $0.run() }
    }
}

var count = 0
struct Incrementer: Runnable {
    func run() {
        count += 1
    }
}

run(runnable: Incrementer())

struct Runners<T>: Runnable where T: Runnable {
    let runnables: [T]

    func run() {
        runnables.forEach { $0.run() }
    }
}

// Runners(runnables: [Incrementer()])
//Runners(runnables: [Incrementer(), Runners(runnables: [Incrementer()])] as [Runnable]).run()

// Runners(runnables: [Running(), Runners(runnables: [Running()])]).run()

protocol RunnableWithResult {
    associatedtype T
    func run() -> T
}

struct RunnersWithResult<T>: RunnableWithResult where T: RunnableWithResult {
    let runnables: [T]
    func run() -> [T.T] {
        return runnables.map { $0.run() }
    }
}

struct IntRunnable: RunnableWithResult {
    func run() -> Int {
        return 0
    }
}

struct StringRunnable: RunnableWithResult {
    func run() -> String {
        return "OK"
    }
}

// Will not compile as the associated types are different
let runnables: [RunnableWithResult] = [StringRunnable(), IntRunnable()]



