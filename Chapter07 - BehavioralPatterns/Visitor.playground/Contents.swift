import Cocoa

var str = "Hello, playground"

protocol Visitor {
    func visit<T>(element: T) where T:Visitable
}
protocol Visitable {
    func accept(visitor: Visitor)
}

// Default implementation for our visitable nodes
extension Visitable {
    func accept(visitor: Visitor) {
        visitor.visit(element: self)
    }
}

// Convenience on Array for visitables
extension Array: Visitable where Element: Visitable {
    func accept(visitor: Visitor) {
        visitor.visit(element: self)
        forEach {
            visitor.visit(element: $0)
        }
    }
}

struct Contribution {
    let author: String
    let email: String
    let date: Date
    let details: String
}

extension Contribution: Visitable {}


class LoggerVisitor: Visitor {
    func visit<T>(element: T) where T : Visitable {
        guard let contribution = element as? Contribution else { return }
        print("\(contribution.author) / \(contribution.email)")
    }
}

let visitor = LoggerVisitor()
[Contribution(author: "Contributor", email: "my@email.com", date: Date(), details: ""), Contribution(author: "Contributor 2", email: "my-other@email.com", date: Date(), details: ""),
 ].accept(visitor: visitor)

let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
let fourDaysAgo = Calendar.current.date(byAdding: .day, value: -4, to: Date())!

class ThankYouVisitor: Visitor {
    var contributions = [Contribution]()

    func visit<T>(element: T) where T : Visitable {
        guard let contribution = element as? Contribution else { return }
        if contribution.date <= threeDaysAgo && contribution.date > fourDaysAgo {
            contributions.append(contribution)
        }
    }
}

let thanksVisitor = ThankYouVisitor()

Contribution(author: "me", email: "not", date: threeDaysAgo, details: "YOLO").accept(visitor: thanksVisitor)

thanksVisitor.contributions

Contribution(author: "older", email: "not", date: fourDaysAgo, details: "YOLO").accept(visitor: thanksVisitor)
thanksVisitor.contributions
assert(thanksVisitor.contributions.count == 1)
