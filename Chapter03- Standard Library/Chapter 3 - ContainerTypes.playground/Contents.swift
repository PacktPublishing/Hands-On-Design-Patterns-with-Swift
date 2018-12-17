//: Playground - noun: a place where people can play

import Foundation

let ints = [1,2,3] // Array<Int> or [Int]
let doubles: [Double] = [1,2,3]

var otherDoubles = doubles
otherDoubles.append(4)
let lastDoubles = otherDoubles.dropFirst()
print(doubles)
print(otherDoubles)
print(lastDoubles)

for value in doubles  {
    print("\(value)") // 1.0, 2.0, 3.0
}

for (idx, value) in doubles.enumerated()  {
    print("\(idx) -> \(value)") // 0 -> 1.0, 1 -> 2.0, 2 -> 3.0
}

doubles.forEach { value in
    // do something with the value
}

let twices = doubles.map { value in
    return "\(value * 2.0)"
} // twices is [String] == ["2.0", "4.0", "6.0"]

let sum = doubles.reduce(0) { $0 + $1 }

let doubleDoubles = doubles.reduce([]) { $0 + [$1, $1] }
doubleDoubles == [1.0, 1.0, 2.0, 2.0, 3.0, 3.0]  // true

let swiftReleases = [
    "2014-09-09": "Swift 1.0",
    "2014-10-22": "Swift 1.1",
    "2015-04-08": "Swift 1.2",
    "2015-09-21": "Swift 2.0",
    "2016-09-13": "Swift 3.0",
    "2017-09-19": "Swift 4.0",
    "2018-03-29": "Swift 4.1"
] // Swift release dates, source Wikipedia

for (key, value) in swiftReleases {
    print("\(key) -> \(value)")
}

swiftReleases.forEach { (key, value) in
    print("\(key) -> \(value)")
}

swiftReleases.enumerated().forEach { (offset, keyValue) in
    let (key, value) = keyValue
    print("[\(offset)] \(key) -> \(value)")
}

typealias Version = (major: Int, minor: Int, patch: Int)

func parse(version value: String) throws -> Version {
    // Parse the string 'Swift 1.0.1' -> (1, 0, 1)
//    fatalError("Provide implementation")
    return (1, 0, 0)
}

let releases: [String: Version] = try swiftReleases.mapValues { (value) ->
    Version in
    try parse(version: value)
}

