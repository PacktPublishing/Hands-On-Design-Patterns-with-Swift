//: Playground - noun: a place where people can play

import PlaygroundSupport
import Foundation
class CreditCard {
    private let queue = DispatchQueue(label: "synchronization.queue")
    private var _balance: Int = 0
    var balance: Int {
        get {
            return queue.sync { _balance }
        } set {
            queue.sync { _balance = newValue }
        }
    }
}

let semaphore = DispatchSemaphore(value: 0)
let queue = DispatchQueue(label: "com.run.concurrent",
                          attributes: .concurrent)
// Run a block 1 second of the future
queue.asyncAfter(deadline: DispatchTime.now() + 1) {
    print("Will Signal")
    semaphore.signal()
    print("Did Signal")
}
print("Will Wait")
// wait for the semaphore, this suspends the current thread
semaphore.wait()
print("Done")

// completion block
let complete = {
    print("DONE!")
}


/**
 Performs some work on any thread
 - parameter done: A block that will be called when the work is done
 - note: This method may not be thread safe
 */
func doWork(done: @escaping () -> ()) {
    /* complex implementation doing important things */
}

// initialize a count for the remaining operations
var count = 0
for i in 0..<4 {
    count += 1 // add one operation
    doWork {
    }
}

let group = DispatchGroup()
// Iterate through all our tasks
for i in 1..<4 {
    // tell the group we're adding additional work
    group.enter()
    // Do the piece of work
    doWork {
        // tell the group the work is done
        group.leave()
    }
}
// tell the group to call complete when done
group.notify(queue: .main, execute: complete)

PlaygroundPage.current.needsIndefiniteExecution = true
