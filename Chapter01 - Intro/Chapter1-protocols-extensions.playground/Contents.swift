 protocol Toggling {
    mutating func toggle()
    var isActive: Bool { get }
 }

 extension Bool: Toggling {}

 extension Toggling where Self == Bool {
    var isActive: Bool {
        return self
    }
 }

 extension Toggling where Self == State {
    var isActive: Bool {
        return self == .on
    }
 }

 enum State: Int, Toggling {
    case off = 0
    case on
    mutating func toggle() {
        self = self == .on ? .off : .on
    }
 }


 protocol Adder {
    func add(value: Int) -> Int
    func remove(value: Int) -> Int
 }

 extension Adder {
    func remove(value: Int) -> Int {
        return add(value: -value)
    }
 }
