//
//  main.swift
//  MemoryLeaker
//
//  Created by Florent Vilmart on 18-04-29.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

let swiftReleases: [String: String] = [
    "2014-09-09": "Swift 1.0",
    "2014-10-22": "Swift 1.1",
    "2015-04-08": "Swift 1.2",
    "2015-09-21": "Swift 2.0",
    "2016-09-13": "Swift 3.0",
    "2017-09-19": "Swift 4.0",
    "2018-03-29": "Swift 4.1",
    "2018-09-17": "Swift 4.2"
]

for (key, value) in swiftReleases {
    print("\(key) -> \(value)")
}

swiftReleases.enumerated().forEach { (offset, keyPair) in
    print("\(offset) -> \(keyPair)")
}

swiftReleases.forEach { (key, value) in
    print("\(key) -> \(value)")
}

class Executor {
    var block: (() -> ())?

    init(block: @escaping (() -> ())) {
        self.block = block
    }

    init() {
        self.block = {
            let _ = self
        }
    }
}

class MemoryLeak {
    weak var ref: MemoryLeak?

    init(_ ref: MemoryLeak) {
        self.ref = ref
    }

    init() {
        ref = self
    }
}

class Card {
    unowned let owner: Person
    init(_ owner: Person) {
        self.owner = owner
    }
}

class Person  {
    let name: String
    var cards = [Card]()
    init(name: String) {
        self.name = name
    }
}

func runTests() {
    let batman = Person(name: "Batman")
    batman.cards.append(Card(batman))
    batman.cards.append(Card(batman))
    batman.cards.append(Card(batman))
}

//runTests()

func crash() -> Card {
    let batman = Person(name: "Batman")
    batman.cards.append(Card(batman))
    return batman.cards.first!
}

func getCard() -> Card {
    let batman = Person(name: "Batman")
    let card = Card(batman)
    batman.cards.append(card)
    return card
}

func getName(card: Card) -> String {
    return card.owner.name
}

let card = getCard()
print("\(card.owner.name)")


//
//
//func simpleCycle() {
//    _ = MemoryLeak()
//}
//
func triangle() -> MemoryLeak {
    let a = MemoryLeak()
    let b = MemoryLeak(a)
    let c = MemoryLeak(b)
    a.ref = c
    return a
}
//
//func fours() {
//    let a = MemoryLeak()
//    let b = MemoryLeak(leak: a)
//    let c = MemoryLeak(leak: b)
//    let d = MemoryLeak(leak: c)
//    a.leak = d
//}
//
func leak(count: Int) -> Void {
    var count = count
    let initial = MemoryLeak()
    var current = initial
    while count > 1 {
        current = MemoryLeak(current)
        count-=1
    }
    initial.ref = current
}

func leak2(count: Int) -> Void {
    var count = count
    let initial = Executor()
    var current = initial
    while count > 1 {
        let c = current
        current = Executor {
            let _ = c
        }
        count-=1
    }
    initial.block = { let _ = current }
}
//
////leak(count: 6)
////func createLeak() {
////    let _ = MemoryLeak()
////}
////
////createLeak()
//
////let a = triangle()
//
////class Hello {
////    func world() {
////        print("Hello, World!")
////    }
////}
////
////let hello = Hello()
////hello.world()
//
//print("Done")
//print("OK")


func run(queue: DispatchQueue, times: Int) {
    let safe = CreditCard()
    (0..<times).forEach { i in
        queue.async {
            safe.balance = i * 3
            print("\(i) operation 1 \(safe.balance)")
            queue.async {
                safe.balance = i * 5
                print("\(i) operation 1.1 \(safe.balance)")
            }
        }
        queue.async {
            safe.balance = i * 7
            print("\(i) operation 2 \(safe.balance)")
        }
    }
}


class CreditCard {
    private let queue = DispatchQueue(label: "synchronization.queue")
    private var _balance: Int = 0

    var balance: Int {
        get {
            return queue.sync {
                _balance
            }
        }
        set {
            queue.sync {
                _balance = newValue
            }
        }
    }
}

 run(queue: DispatchQueue(label: "com.run.concurrent", attributes: .concurrent), times: 10)


 let semaphore = DispatchSemaphore(value: 0)

let queue = DispatchQueue(label: "com.run.serial", attributes: .concurrent)

queue.asyncAfter(deadline: DispatchTime.now() + 1) {

    print("Will Signal")
    semaphore.signal()

    print("Did Signal")

}

print("Will Wait")
semaphore.wait()
print("Done")

let group = DispatchGroup()
var i = 0

func doWork(index: Int) {
    queue.asyncAfter(deadline: DispatchTime.now() + 0.2 * Double(index)) {
        print("YOLO")
        group.leave()
    }
    group.enter()
}

typealias Block = () -> ()
typealias FunctionWithCallback = (@escaping Block) -> ()

/**
 Runs asynchronous functions and calls completion when all is done
 - parameter blocks: List of functions to run
 - parameter completion: A block to call when all functions have completed
 */
func runAll(blocks: [FunctionWithCallback], completion: @escaping Block) {
    let group = DispatchGroup()
    blocks.forEach { (function) in
        group.enter()
        function {
            group.leave()
        }
    }
    group.notify(queue: .main, execute: completion)
}
func someWork(block: @escaping Block) {
    queue.asyncAfter(deadline: DispatchTime.now() + 0.2) {
        print("YOLO")
        block()
    }
}

runAll(blocks: [someWork, someWork]) {
    print("DOME ALL")
}

/**
 Performs some work on any thread
 - parameter done: A block that will be called when the work is done
 - note: This method may not be thread safe
 */
func doWork(done: @escaping () -> ()) {
    /* */
}

(0..<100).forEach(doWork)

group.notify(queue: .main) {
    print("Done ")
}


func get<T>(url: URL, callback: @escaping (T?, Error?) -> Void) -> URLSessionTask where T: Decodable {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            callback(nil, error)
            return
        }
        if let data = data {
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                callback(result, nil)
            } catch let error {
                callback(nil, error)
            }
        } else {
            callback(nil, nil)
        }
    }
    task.resume()
    return task
}

extension URLRequest {
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    init<T>(url: URL, method: HTTPMethod, body: T?) throws where T: Encodable {
        self.init(url: url)
        httpMethod = method.rawValue
        if let body = body  {
            httpBody = try JSONEncoder().encode(body)
        }
    }
}

func responseHandler<T>(data: Data?, response: URLResponse?, error: Error?, callback: @escaping (T?, Error?) -> Void) where T: Decodable {
    if let error = error {
        callback(nil, error)
        return
    }
    if let data = data {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            callback(result, nil)
        } catch let error {
            callback(nil, error)
        }
    } else {
        callback(nil, nil)
    }
}

extension URLSession {
    func dataTask<T>(with request: URLRequest, callback: @escaping (T?, Error?) -> Void) throws -> URLSessionTask where T: Decodable {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            responseHandler(data: data, response: response, error: error, callback: callback)
        }
    }
}

func post<T, U>(url: URL, body: U, callback: @escaping (T?, Error?) -> Void) throws -> URLSessionTask where T: Decodable, U: Encodable {
    var request = URLRequest(url: url)
    request.httpBody = try JSONEncoder().encode(body)
    request.httpMethod = "POST"
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            callback(nil, error)
            return
        }
        if let data = data {
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                callback(result, nil)
            } catch let error {
                callback(nil, error)
            }
        } else {
            callback(nil, nil)
        }
    }
    task.resume()
    return task
}

struct MyResult: Decodable {
    let intValue: Int
}

struct MyBody: Encodable {}

let request = try! URLRequest(url: URL(string: "http://example.com")!,
                              method: .POST,
                              body: MyBody())
let task = try? URLSession.shared.dataTask(with: request) { (result: MyResult?, error) in
    // Handle error
}
task?.resume()

_ = get(url: URL(string: "http://example.com")!) { (result: MyResult?, error) in
    switch (result, error) {
    case (.some(let result), _):
        print(result)
    case (_, .some(let error)):
        print("There was an error", error)
    default:
        print("meh")
    }
}

dispatchMain()
