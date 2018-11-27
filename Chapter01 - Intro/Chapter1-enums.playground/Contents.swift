//: Playground - noun: a place where people can play

enum State<T>: Equatable where T: Equatable {
    case on
    case off
    case dimmed(T)
}

extension State {
    mutating func toggle() {
        self = self == .off ? .on : .off
    }
}

let s = State.dimmed(1000)

struct Bits16Dimming: Equatable {
    let value: Int
    init(_ value: Int) {
        assert(value > 0 && value < 256)
        self.value = value
    }
}

struct ZeroOneDimming: Equatable {
    let value: Double
    init(_ value: Double) {
        assert(value > 0 && value < 1)
        self.value = value
    }
}



extension Double {

}

let s2 = State.dimmed(Bits16Dimming(20))
State.dimmed(ZeroOneDimming(0.4))
switch s2 {
case let .dimmed(value):
    print("value \(value)")
default:
    break
}

let nostalgiaState: State<Bits16Dimming> = .dimmed(.init(10))
let otherState: State<ZeroOneDimming> = .dimmed(.init(0.4))


let b: State<ZeroOneDimming> = .dimmed(ZeroOneDimming(0.3))

enum LightLevel: String {
    case quarter
    case half
    case threeQuarters
}


var c: State<LightLevel> = .dimmed(LightLevel.half)

switch c {
case .on:
    break
case .off:
    break
case .dimmed(let value):
    switch value {
    case .quarter:
        break
    case .half:
        break
    case .threeQuarters:
        break
    }
}

enum Level: Int {
    case base // == 0
    case more // == 1
    case high = 100
    case higher // == 101
}

Level.higher.rawValue

c = .on

switch c {
case .on:
    print("on")
    fallthrough
case .off:
    print("off")
default: break
}

protocol Toggling {
    mutating func toggle()
}
