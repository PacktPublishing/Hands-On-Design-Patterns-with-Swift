//: Playground - noun: a place where people can play

import UIKit

let array = [1, 2, 3]

func printIt(x: Int) {
    print(x);
}

array.forEach { print($0) } // 1 2 3

array.forEach(printIt)

// Using forEach with a closure:
(1...5).forEach { value in
    print("\(value)")
}

// The above is equivalente to this:
func printValue<T>(val : T) { print("\(val)") }
(1...5).forEach(printValue)

// No need for return statement in single-expression closures:
let squares1 = (1...5).map { value in
    value * value
}

// Even better:
let squares2 = (1...5).map { $0 * $0 }

