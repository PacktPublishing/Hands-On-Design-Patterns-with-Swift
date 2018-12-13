import Cocoa

var str = "Hello, playground"

protocol Food {}

protocol Animal {
    associatedtype FoodType: Food
    func eat(food: FoodType)
}

struct Grass: Food {}
struct Cow: Animal {
    func eat(food: Grass) {
        print("Grass is yummy! moooooo!")
    }
}
struct Goat: Animal {
    func eat(food: Grass) {
        print("Grass is good! meehhhh!")
    }
}

struct Meat: Food {}
struct Lion: Animal {
    func eat(food: Meat) {}
}

//var animals = [Animal]()

class AnimalHolder<T> where T: Animal {
    var animals = [T]()
}

let holder = AnimalHolder<Cow>()
//let animals = [Animal]()
//
//func feed(animal: Animal) {
//
//}

//func feed<A>(animal: A) where A: Animal, A.FoodType == Grass {
//    animal.eat(food: Grass())
//}

func feed<A: Animal>(animal: A) {
    switch animal {
    case let a as Lion:
        print("OK \(a)")
    case let a as Cow:
        print("Feed a \(a)")
    default:
        print("\(animal)")
        break
    }
}


let cow = Cow()
feed(animal: cow)
print("fed cow...")
let lion = Lion()
feed(animal: lion)
print("fed lion...")


func compareInts(_ a: Int, _ b: Int) -> Int {
    if a > b { return 1 }
    if a < b { return -1 }
    return 0
}

func compareDoubles(_ a: Double, _ b: Double) -> Int {
    if a > b { return 1 }
    if a < b { return -1 }
    return 0
}

func compare<T>(_ a: T, _ b: T) -> Int where T: Comparable {
    if a > b { return 1 }
    if a < b { return -1 }
    return 0
}

compareInts(1, 2)
compareDoubles(2.0, 3.0)

enum Result<T> {
    case success(T), error(Error)
}

enum Either<T, U> {
    case left(T), right(U)
}

protocol Summable {
    associatedtype SumType
    var sum: SumType { get }
}

//
//extension Array: Summable where Element == Int {
//    typealias SumType = Int
//    var sum: Int {
//        return self.reduce(0) { $0 + $1 }
//    }
//}


extension Array: Summable where Element: Numeric {
    typealias SumType = Element
    var sum: Element {
        return self.reduce(0) { $0 + $1 }
    }
}

let intSum = [1,2,3,4,5].sum
let doubleSum = [1.0, 2.0, 3.0, 4.0].sum
let floatSum: Float = [1.0, 2.0, 3.0, 4.0].sum
extension Array where Element == String {
    var sum: String {
        return self.reduce("") { $0 + $1 }
    }
}

["a", "b", "c"].sum

["Hello", " ", "World", "!"].sum  == "Hello World!"

final class AnyAnimal<T>: Animal where T: Food {
    typealias FoodType = T

    private let eatBlock: (T) -> Void
    init<L: Animal>(animal: L) where L.FoodType == T {
        eatBlock = animal.eat
    }

    func eat(food: T) {
        eatBlock(food)
    }
}


//class AnyCow: AnyAnimal<Grass> {}

let aCow = AnyAnimal(animal: Cow())
let aGoat = AnyAnimal(animal: Goat())
let grassEaters = [aCow, aGoat]
assert(grassEaters is [AnyAnimal<Grass>])

grassEaters.forEach { (animal) in
    animal.eat(food: Grass())
}
//
//var a: [Animal] = [Cow(), Goat()]

