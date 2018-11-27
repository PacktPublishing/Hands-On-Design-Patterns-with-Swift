import Cocoa

protocol Food {}

protocol Animal {
    associatedtype FoodType: Food
    var preferredFood: FoodType? { get set }
    var name: String { get }
    func eat(food: FoodType)
}

//final class AnyAnimal<T>: Animal where T: Food {
//    var preferredFood: T?
//    let name: String = ""
//
//    typealias FoodType = T
//
//    func eat(food: T) {}
//}

private class _AnyAnimalBase<F>: Animal where F: Food {
    var preferredFood: F? {
        get { fatalError() }
        set { fatalError() }
    }

    var name: String {
       fatalError()
    }

    func eat(food: F) {
        fatalError()
    }
}


private final class _AnyAnimalBox<A: Animal>: _AnyAnimalBase<A.FoodType> {
    // variable used since we're calling mutating functions
    var target: A

    init(_ target: A) {
        self.target = target
    }

    override var name: String {
        return target.name
    }

    override var preferredFood: A.FoodType? {
        get {
            return target.preferredFood
        }
        set {
            target.preferredFood = newValue
        }
    }

    override func eat(food: A.FoodType) {
        target.eat(food: food)
    }
}


final class AnyAnimal<T>: Animal where T: Food {
    typealias FoodType = T

    private let box: _AnyAnimalBase<T>

    init<A: Animal>(_ animal: A) where A.FoodType == T {
        box = _AnyAnimalBox(animal)
    }

    var preferredFood: T? {
        get { return box.preferredFood }
        set { box.preferredFood = newValue }
    }
    var name: String {
        return box.name
    }
    func eat(food: T) {
        box.eat(food: food)
    }
}

class Grass: Food {}
class Flower: Grass {}
class Dandelion: Grass {}
class Shamrock: Grass {}

extension Animal where FoodType: Grass {
    func eat(food: FoodType) {
        if let preferredFood = preferredFood,
            type(of: food) == type(of: preferredFood) {
            print("\(name): Yummy! \(type(of: food))")
        } else {
            print("\(name): I'm eating...")
        }
    }
}

struct Cow: Animal {
    var name: String
    var preferredFood: Grass? = nil
}

struct Goat: Animal {
    var name: String
    var preferredFood: Grass? = nil
}

let flock = [
    AnyAnimal(Cow(name: "Bessie", preferredFood: Dandelion())),
    AnyAnimal(Cow(name: "Henrietta", preferredFood: nil)),
    AnyAnimal(Goat(name: "Billy", preferredFood: Shamrock())),
    AnyAnimal(Goat(name: "Nanny", preferredFood: Flower()))
]


let flowers = [
    Grass(),
    Dandelion(),
    Flower(),
    Shamrock()
]

while true {
    flock.randomElement()?
        .eat(food: flowers.randomElement()!)
    sleep(1)
}
