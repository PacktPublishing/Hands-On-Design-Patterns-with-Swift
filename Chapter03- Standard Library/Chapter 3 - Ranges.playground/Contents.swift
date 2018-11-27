//: Playground - noun: a place where people can play

import Cocoa


let doubles: [Double] = [1,2,3]
var otherDoubles = doubles
otherDoubles.append(4)
let lastDoubles = otherDoubles.dropFirst()

print(doubles)
print(otherDoubles)
print(lastDoubles)

for (index, value) in doubles.enumerated()  {
    print("\(index) -> \(value)")
}

doubles.forEach { (value) in
    // do somehing
}

let sum = doubles.reduce([]) { $0 + [$1, $1] }

sum
print(sum)


let dict = ["Key": "Value"]

//try? card.charge(amount: 2000)
//card.balance == 8000
//try? card.charge(amount: -10000)
let d = Date(timeIntervalSince1970: 12345)
let aDict = ["213": "Yolo"]
let formatter = DateFormatter()
formatter.dateFormat = "yyyy-MM-dd"
formatter.date(from: "2018-10-01")

let importantDates = [
    "2014-09-09": "Swift 1.0",
    "2014-10-22": "Swift 1.1",
    "2015-04-08": "Swift 1.2",
    "2015-09-21": "Swift 2.0",
    "2016-09-13": "Swift 3.0",
    "2017-09-19": "Swift 4.0",
    "2018-03-29": "Swift 4.1"
] // Swift release dates, source Wikipedia﻿

let a = importantDates.reduce(into: [Date: String]()) { (result, keyValue) in
    if let date = formatter.date(from: keyValue.key) {
        result[date] = keyValue.value
    }
}.reduce((), <#T##nextPartialResult: (Result, (key: Date, value: String)) throws -> Result##(Result, (key: Date, value: String)) throws -> Result#>)

a

let res = importantDates.reduce([Date: String]()) { (res, keyValue) -> [Date: String] in
    var res = res
    if let date = formatter.date(from: keyValue.key) {
        res[date] = keyValue.value
    }
    return res
}

print(res)
