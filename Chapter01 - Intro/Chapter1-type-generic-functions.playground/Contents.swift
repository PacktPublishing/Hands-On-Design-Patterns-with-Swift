import Foundation

func concat<T>(a: T, b: T) -> [T] {
    return [a,b]
}

protocol Runnable {
    func run()
}

func run<T>(runnable: T) where T: Runnable {
    runnable.run()
}

struct ManyRunner<T>: Runnable where T: Runnable {
    let runnables: [T]
    func run() {
        runnables.forEach { $0.run() }
    }
}

struct Incrementer: Runnable {
    private(set) static var count = 0
    func run() {
        Incrementer.count += 1
    }
}

// This works
let runner = ManyRunner(runnables: [Incrementer(),Incrementer()])
runner.run()
assert(Incrementer.count == 2)
// runner is of type ManyRunner<Incrementer>
//ManyRunner(runnables: [Incrementer(), Runners(runnables: [Incrementer()])] as [Runnable]).run()
// This produces the following compile error
// In argument type '[Runnable]', 'Runnable' does not conform to expected type 'Runnable'
