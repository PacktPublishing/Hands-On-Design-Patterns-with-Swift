import Foundation
import UIKit

public class Observable<Type> {
    public typealias Observer = (Type) -> ()
    public typealias Token = NSObjectProtocol

    private var observers = [(Token, Observer)]()

    public var value: Type {
        didSet {
            notify()
        }
    }

    public init(_ value: Type) {
        self.value = value
    }

    @discardableResult
    public func bind(_ observer: @escaping Observer) -> Token {
        // notify with the current value
        defer {
            observer(value)
        }
        let obj = NSObject()
        observers.append((obj, observer))
        return obj
    }

    public func unbind(_ token: Token) {
        observers.removeAll { $0.0.isEqual(token) }
    }

    private func notify() {
        observers.forEach { (_, observer) in
            observer(value)
        }
    }
}


//let observable = Observable("")
//
//let token0 = observable.bind {
//    print("Changed 0: \($0)")
//}
//observable.value = "OK"
//
//let token1 = observable.bind {
//    print("Changed 1: \($0)")
//}
//
//observable.unbind(token1)
//
//observable.value = "NOK"

public protocol Bindable: AnyObject {
    associatedtype BoundType
    var boundValue: BoundType { get set }
}

private struct BindableAssociatedKeys {
    static var observable: UInt8 = 0
    static var box: UInt8 = 0
}

public extension Bindable where Self: NSObjectProtocol {
    private var observable: Observable<BoundType>? {
        get {
            return objc_getAssociatedObject(self, &BindableAssociatedKeys.observable) as? Observable<BoundType>
        }
        set {
            objc_setAssociatedObject(self, &BindableAssociatedKeys.observable, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

public extension Bindable where Self: UIControl {
    private var target: Target? {
        get {
            return objc_getAssociatedObject(self, &BindableAssociatedKeys.box) as? Target
        }
        set {
            objc_setAssociatedObject(self, &BindableAssociatedKeys.box, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func bind(_ observable: Observable<BoundType>) {
        self.observable = observable
        let target = Target()
        // retain the box
        self.target = target
        target.onValueChanged = {
            self.observable?.value = self.boundValue
        }
        addTarget(target, action: #selector(Target.valueChanged), for: [.editingChanged, .valueChanged])
        observable.bind { (value) in
            self.boundValue = value
        }
    }
}

internal class Target {
    var onValueChanged: (() -> ())?
    @objc func valueChanged() {
        onValueChanged?()
    }
}

extension UITextField: Bindable {
    public var boundValue: String? {
        get { return self.text }
        set { self.text = newValue }
    }
}

extension UIStepper: Bindable {
    public var boundValue: Double {
        get { return self.value }
        set { self.value = newValue }
    }
}
