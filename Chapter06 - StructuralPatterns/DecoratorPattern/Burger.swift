//
//  Burger.swift
//  DecoratorPattern
//
//  Created by Florent Vilmart on 2018-06-05.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

public protocol Burger {
    var price: Double { get }
    var ingredients: [String] { get }
}

public protocol BurgerDecorator: Burger {
    var burger: Burger { get }
}

extension BurgerDecorator {
    public var price: Double {
        return burger.price
    }
    public var ingredients: [String] {
        return burger.ingredients
    }
}

public struct BaseBurger: Burger {
    public var price = 1.0
    public var ingredients = ["buns"]
}

public struct WithCheese: BurgerDecorator {
    public let burger: Burger

    public var price: Double {
        return burger.price + 0.5
    }

    public var ingredients: [String] {
        return burger.ingredients + ["cheese"]
    }
}

public struct WithVeggiePatty: BurgerDecorator {
    public let burger: Burger

    public var price: Double {
        return burger.price + 2.0
    }

    public var ingredients: [String] {
        return burger.ingredients + ["Veggie Pattie"]
    }
}

public struct WithIncredibleBurgerPatty: BurgerDecorator {
    public let burger: Burger

    public var price: Double {
        return burger.price + 2.0
    }

    public var ingredients: [String] {
        return burger.ingredients + ["incredible burger"]
    }
}

public enum FreeIngredient {
    case salad(burger: Burger)
    case tomato(burger: Burger)
    case mushroom(burger: Burger)

    var rawValue: String {
        switch self {
        case .mushroom(burger: _):
            return "mushroom"
        case .salad(burger: _):
            return "salad"
        case .tomato(burger: _):
            return "tomato"
        }
    }
}

extension FreeIngredient: BurgerDecorator {
    public var burger: Burger {
        switch self {
        case .mushroom(let burger):
            return burger
        case .salad(let burger):
            return burger
        case .tomato(let burger):
            return burger
        }
    }

    public var ingredients: [String] {
        return burger.ingredients + [rawValue]
    }
}

public enum Topping: String {
    case mayo
    case ketchup
    case salad
    case tomato
}

extension Topping {
    func decorate(burger: Burger) -> WithTopping {
        return WithTopping(burger: burger, topping: self)
    }
}

struct WithTopping: BurgerDecorator {
    let burger: Burger
    let topping: Topping

    var ingredients: [String] {
        return burger.ingredients + [topping.rawValue]
    }
}

struct WithBurger<T>: BurgerDecorator where T: Burger {
    var burger: Burger
    private let t: T

    init(burger: Burger, other: T) {
        self.burger = burger
        self.t = other
    }

    var price: Double {
        return burger.price + t.price
    }

    var ingredients: [String] {
        return burger.ingredients + t.ingredients
    }
}
