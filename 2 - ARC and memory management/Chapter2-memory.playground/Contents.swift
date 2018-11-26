//: Playground - noun: a place where people can play

import PlaygroundSupport
import Foundation

struct Box {
    var intValue: Int
    init(intValue: Int) {
        self.intValue = intValue
    }
}

var b = Box(intValue: 10)
let c = b
let block = {
    print(b.intValue)
    b.intValue = 20
}

func doSomething(_ block: @escaping ()->()) {
    DispatchQueue.main.async {
        block()
        print(b.intValue)
        print(c.intValue)
    }
}

b.intValue = 0
//block()

doSomething(block)

PlaygroundPage.current.needsIndefiniteExecution = true
