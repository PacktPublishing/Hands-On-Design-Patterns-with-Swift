//
//  DecoratorPatternTests.swift
//  DecoratorPatternTests
//
//  Created by Florent Vilmart on 2018-06-05.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import XCTest
@testable import DecoratorPattern

class DecoratorPatternTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        func doIt() {
            
//            var b: Burger = BaseBurger()
//            b = FreeIngredient.tomato(burger: b)
//            b = WithCheese(burger: b)
//            b = WithIncredibleBurgerPatty(burger: b)

            var b: Burger = BaseBurger() // it's just a simple burger
            b = WithTopping(burger: b, topping: .ketchup) // put the mayo first
            b = WithCheese(burger: b) // Add some cheese
            b = WithIncredibleBurgerPatty(burger: b) // Add the patty
            b = WithTopping(burger: b, topping: .salad)

            assert(b.ingredients == ["buns", "ketchup", "cheese", "incredible burger", "salad"])
            assert(b.price == 3.5)


            var decorators = [(Burger) -> Burger]()
            decorators.append(Topping.ketchup.decorate)
            decorators.append(WithCheese.init)
            decorators.append(WithIncredibleBurgerPatty.init)
            decorators.append(Topping.salad.decorate)

            let burger = decorators.reduce(into: BaseBurger()) { burger, decorator in
                burger = decorator(burger)
            }

            let result = decorators.reduce(BaseBurger()) { (burger, decorator) -> Burger in
                return decorator(burger)
            }

            assert(b.ingredients == result.ingredients)
            assert(b.price == result.price)
            print("\(result.ingredients.joined(separator: ","))")
            print("\(result.price)")
        }

        doIt()
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
