//
//  main.swift
//  MemoryLeaker
//
//  Created by Giordano Scalzo on 12/12/2018.
//  Copyright © 2018 Giordano Scalzo. All rights reserved.
//

import Foundation

class Card {
    let owner: Person
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
runTests()
