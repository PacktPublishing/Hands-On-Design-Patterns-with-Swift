//: Playground - noun: a place where people can play

protocol Toggling {
    mutating func toggle()
}

enum State: Int, Toggling {
    case off = 0
    case on
    mutating func toggle() {
        self = self == .on ? .off : .on
    }
}
var state: State = .on
state.toggle()
assert(state == .off)

extension Bool: Toggling {
    mutating func toggle() {
        self = !self }
}
var isReady = false
isReady.toggle()
assert(isReady)
