//
//  Flyweight.swift
//  StructuralPatterns
//
//  Created by Giordano Scalzo on 13/12/2018.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

struct Ingredient: CustomDebugStringConvertible {
    let name: String
    var debugDescription: String {
        return name
    }
}

struct IngredientManager {
    private var knownIngredients = [String: Ingredient]()
    mutating func get(withName name: String) -> Ingredient {
        // Check if we have already an instance
        guard
            let ingredient = knownIngredients[name] else {
                // Register an instance
                knownIngredients[name] = Ingredient(name: name)
                // Attempt to get again
                return get(withName: name)
        }
        return ingredient
    }
    var count: Int {
        return knownIngredients.count
    }
}

struct ShoppingList: CustomDebugStringConvertible {
    private var list = [(Ingredient, Int)]()
    private var manager = IngredientManager()
    mutating func add(item: String, amount: Int = 1) {
        let ingredient = manager.get(withName: item)
        list.append((ingredient, amount))
    }
    var debugDescription: String {
        return "\(manager.count) Items:\n\n"
            + list.map { (ingredient, value) in
                return "\(ingredient) (x\(value))"
                }.joined(separator: "\n")
    }

}


