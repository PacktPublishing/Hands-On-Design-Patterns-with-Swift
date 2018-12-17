//: Playground - noun: a place where people can play

import PlaygroundSupport
import Foundation

struct Box {
    var intValue: Int
}

let box = Box(intValue: 0)
var otherBox = box
otherBox.intValue = 10
assert(box.intValue == 0) // box and otherBox don't share the same reference
assert(otherBox.intValue == 10)

class Task {
    let description: String
    weak var worker: Worker? = nil
    init(description: String) {
        self.description = description
    }
}

class Worker {
    var name: String
    var currentTask: Task? = nil

    init(name: String) {
        self.name = name
    }
}
let worker = Worker(name: "John Snow")
let task = Task(description: "Night's Watch Commander")
worker.currentTask = task
task.worker = worker
// John snow is the night watch's commander
worker.currentTask = nil
// the task will be deallocated

class CreditCard {
    let number: String
    let expiry: String
    unowned let owner: Person
    init(owner: Person) {
        self.owner = owner
        self.number = "XXXXXXXXXXXXXXXX"
        self.expiry = "XX/YY"
    }
}

class Person {
    let name: String
    var cards: [CreditCard] = []
    init(name: String) {
        self.name = name
    }
}

let me = Person(name: "John Smith")
let card = CreditCard(owner: me)
let otherCard = CreditCard(owner: me)
me.cards = [card, otherCard]
