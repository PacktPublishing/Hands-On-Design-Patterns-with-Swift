import Cocoa

var str = "Hello, playground"

protocol AbstractionType {

    init(implementor: ImplementorType)

    func start()
    func stop()
}

extension AbstractionType {
    func restart() {
        stop()
        start()
    }
}

protocol ImplementorType {
    func start()
    func stop()
}

class Abstraction: AbstractionType {
    let implementor: ImplementorType
    required init(implementor: ImplementorType) {
        self.implementor = implementor
    }

    func start() {
        implementor.start()
    }

    func stop() {
        implementor.stop()
    }
}

class Implementor1: ImplementorType {
    func start() {
        print("Implementor1.start()")
    }
    func stop() {
        print("Implementor1.stop()")
    }
}

class Implementor2: ImplementorType {
    func start() {
        print("Implementor2.start()")
    }
    func stop() {
        print("Implementor2.stop()")
    }
}


var abstraction = Abstraction(implementor: Implementor1())
abstraction.restart()

abstraction = Abstraction(implementor: Implementor2())
abstraction.restart()

class TestImplementor: ImplementorType {
    var stopCalled = false
    var startCalled = false
    var inProperOrder = false

    func start() {
        inProperOrder = stopCalled == true && startCalled == false
        startCalled = true
        print("TestImplementor.start() \(startCalled) \(stopCalled) \(inProperOrder)")
    }

    func stop() {
        inProperOrder = startCalled == false && stopCalled == false
        stopCalled = true
        print("TestImplementor.stop() \(startCalled) \(stopCalled) \(inProperOrder)")
    }
}

let testImplementor = TestImplementor()

abstraction = Abstraction(implementor: testImplementor)
abstraction.restart()
assert(testImplementor.inProperOrder)
assert(testImplementor.startCalled)
assert(testImplementor.stopCalled)
