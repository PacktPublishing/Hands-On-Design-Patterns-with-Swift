struct Ingredient: CustomDebugStringConvertible {
    let name: String

    var debugDescription: String {
        return name
    }
}

struct IngredientManager {
    private var knownIngredients = [String: Ingredient]()

    mutating func get(withName name: String) -> Ingredient {
        guard
            let ingredient = knownIngredients[name] else {
            knownIngredients[name] = Ingredient(name: name)
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
        return "\(manager.count) Ingredients:\n\n"
            + list.map { (ingredient, value) in
                return "\(ingredient) x \(value)"
            }.joined(separator: "\n")
    }
}

var list = ShoppingList()
let items = ["kale", "carrots", "salad", "carrots", "cucumber", "celery", "pepper", "bell pepers", "carrots", "salad"]

items.count
items.forEach {
    list.add(item: $0)
}

print(list)

