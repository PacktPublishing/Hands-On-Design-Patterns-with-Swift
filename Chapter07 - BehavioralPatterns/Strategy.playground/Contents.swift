import Cocoa

protocol Strategy {
    associatedtype ReturnType
    associatedtype ContextType
    func run(context: ContextType) -> ReturnType
}

protocol Context {
    associatedtype StrategyType: Strategy
    var strategy: StrategyType { get set }
}


enum IceCreamPart {
    case waffer
    case cup
    case scoop(Int)
    case chocolateDip
    case candyTopping

    var price: Double {
        switch self {
        case .scoop:
            return 2.0
        default:
            return 0.25
        }
    }

    var description: String {
        switch self {
        case .scoop(let count):
            return "\(count)x scoops"
        case .waffer:
            return "1x waffer"
        case .cup:
            return "1x cup"
        case .chocolateDip:
            return "1x chocolate dipping"
        case .candyTopping:
            return "1x candy topping"
        }
    }
}

protocol BillingStrategy {
    func add(item: IceCreamPart) -> Double
}

class FullPriceStrategy: BillingStrategy {
    func add(item: IceCreamPart) -> Double {
        switch item {
        case .scoop(let count):
            return Double(count) * item.price
        default:
            return item.price
        }
    }
}

class HalfPriceToppings: FullPriceStrategy {
    override func add(item: IceCreamPart) -> Double {
        if case .candyTopping = item {
            return item.price / 2.0
        }
        return super.add(item: item)
    }
}

struct Bill {
    var strategy: BillingStrategy
    var items = [(IceCreamPart, Double)]()

    init(strategy: BillingStrategy) {
        self.strategy = strategy
    }

    mutating func add(item: IceCreamPart) {
        let price = strategy.add(item: item)
        items.append((item, price))
    }

    func total() -> Double {
        return items.reduce(0) { (total, item) -> Double in
            return total + item.1
        }
    }
}

extension Bill: CustomStringConvertible {
    var description: String {
        return items.map { (item) -> String in
            return item.0.description + " $\(item.1)"
        }.joined(separator: "\n")
            + "\n----------"
            + "\nTotal $\(total())\n"
    }
}


var bill = Bill(strategy: FullPriceStrategy())
bill.add(item: .waffer)
bill.add(item: .scoop(1))
bill.add(item: .candyTopping)

print(bill)

bill = Bill(strategy: FullPriceStrategy())
bill.add(item: .cup)
bill.add(item: .scoop(3))
bill.strategy = HalfPriceToppings()
bill.add(item: .candyTopping)

print(bill)

class HalfPriceStrategy: FullPriceStrategy {
    override func add(item: IceCreamPart) -> Double {
        return super.add(item: item) / 2.0
    }
}

bill = Bill(strategy: HalfPriceStrategy())
bill.add(item: .waffer)
bill.add(item: .scoop(1))
bill.add(item: .candyTopping)

print(bill)
