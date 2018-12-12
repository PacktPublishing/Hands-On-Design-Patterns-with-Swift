//: Playground - noun: a place where people can play

import PlaygroundSupport
import Foundation

DispatchQueue.main.async {
    print("operation 1")
    DispatchQueue.main.async {
        print("operation 1.1")
    }
}
DispatchQueue.main.async {
    print("operation 2")
}


func run(queue: DispatchQueue, times: Int) {
    (0..<times).forEach { i in
        queue.async {
            print("\(i) operation 1")
            queue.async { print("\(i) operation 1.1") }
        }
        queue.async {
            print("\(i) operation 2")
        }
    }
}

run(queue: .main, times: 3)


let queue = DispatchQueue(label: "com.run.concurrent",
                          attributes: .concurrent)
run(queue: queue, times: 3)

PlaygroundPage.current.needsIndefiniteExecution = true
