//: Playground - noun: a place where people can play

import Foundation

let range1 = 0..<10
let range2 = 0...9
range1.contains(10) // false

let uppercased = "A"..."Z"
uppercased.contains("C") // true
uppercased.contains("c") // false
uppercased ~= "Z" // true

extension Range: Sequence where Bound: Strideable, Bound.Stride :
SignedInteger {
    public typealias Element = Bound
    public typealias Iterator = IndexingIterator<Range<Bound>>
}

let doubles = (1..<10).map { $0 * 2 } // [2,4,6,8,10,12,14,16,18]
for i in 1..<10 {
    // do something with i
}

