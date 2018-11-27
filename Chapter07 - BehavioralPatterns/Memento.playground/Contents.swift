import Cocoa

protocol Originator {
    associatedtype MementoType
    func createMemento() -> MementoType
    mutating func setMemento(_ memento: MementoType)
}

protocol CareTaker {
    associatedtype OriginatorType: Originator

    var originator: OriginatorType { get set }
    var mementos: [OriginatorType.MementoType] { get set }

    mutating func save()
    mutating func restore()
}

extension CareTaker {
    mutating func save() {
        mementos.append(originator.createMemento())
    }

    mutating func restore() {
        guard let memento = mementos.popLast() else  { return }
        originator.setMemento(memento)
    }
}


class StateProducer: Originator {
    var string: String = ""
    func createMemento() -> String {
        return string
    }

    func setMemento(_ memento: String) {
        string = memento
    }
}

class StateProducerTaker: CareTaker {
    var originator: StateProducer
    var mementos: [String] = []

    init(originator: StateProducer) {
        self.originator = originator
    }
}

let producer = StateProducer()
var careTaker = StateProducerTaker(originator: producer)

careTaker.save()
print(producer.string)
producer.string = "Hello"
print(producer.string)
careTaker.save()
producer.string = "World"
print(producer.string)
careTaker.restore()
print(producer.string)
careTaker.restore()

struct Item {
    var name: String
    var done: Bool = false
}

let list = [
    Item(name: "Fish", done: false),
    Item(name: "Carrots", done: false),
    Item(name: "", done: false)
]

extension Array: Originator {
    func createMemento() -> [Element] {
        return self
    }
    mutating func setMemento(_ memento: [Element]) {
        self = memento
    }
}

class ShoppingList: CareTaker {
    var mementos: [[Item]] = []

    var list = [Item]()
    var originator: [Item] {
        get { return list }
        set { list = newValue }
    }

    func add(_ name: String) {
        list.append(Item(name: name, done: false))
    }

    func toggle(itemAt index: Int) {
        list[index].done.toggle()
    }
}

extension String {
    var strikeThrough: String {
        return self.reduce("", { (res, char) -> String in
            return res + "\(char)" + "\u{0336}"
        })
    }
}

extension Item: CustomStringConvertible {
    var description: String {
        return done ? name.strikeThrough : name
    }
}

extension ShoppingList: CustomStringConvertible {
    var description: String {
        return list.map {
            $0.description
        }.joined(separator: "\n")
    }
}

var shoppingList = ShoppingList()
shoppingList.add("Fish")
shoppingList.save()
shoppingList.add("Karrots")
shoppingList.restore()
print("---\n\(shoppingList)\n---")

shoppingList.add("Carrots")
print("---\n\(shoppingList)\n---")

shoppingList.save()
shoppingList.toggle(itemAt: 1)
print("---\n\(shoppingList)\n---")

shoppingList.restore()
print("---\n\(shoppingList)\n---")
