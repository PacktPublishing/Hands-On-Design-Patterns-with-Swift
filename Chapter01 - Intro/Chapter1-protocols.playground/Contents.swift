//: Playground - noun: a place where people can play

import Cocoa

//protocol Adder {
//    func add(value: Int) -> Int
//    func remove(value: Int) -> Int
//}
//
//extension Adder {
//    func remove(value: Int) -> Int {
//        return add(value: -value)
//    }
//}

let origin = (0.0, 0.0)
let point = (x: 3.0, y: 4.0)


func distance(_ a: (Double, Double),_ b: (Double, Double)) -> Double {
    return sqrt(pow(b.0 - a.0, 2) + pow(b.1 - a.1, 2))
}

distance(point, origin)

func slope(_ a: (x: Double, y: Double),_ b: (x: Double, y: Double)) -> Double {
    return (b.1 - a.1) / (b.0 - a.0)
}

slope((2, 2), origin)

typealias MyString = String
typealias TypedBlock<T, U> = (T) -> U
typealias Block = TypedBlock<(), Void>

let b: Block = { _ in

}

protocol SomeProtocol {}
protocol OtherProtocol {}

typealias Some = NSViewController & OtherProtocol
typealias Both = OtherProtocol & SomeProtocol

