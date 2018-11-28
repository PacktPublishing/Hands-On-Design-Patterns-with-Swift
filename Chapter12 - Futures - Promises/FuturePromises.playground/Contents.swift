public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

enum SimpleError: Error {
    case errorCause1
    case errorCause2
}

typealias Callback<T> = (Result<T>) -> Void

public class Future<T> {

    internal var result : Result<T>? {
        didSet {
            if let result = result, let callback = callback {
                callback(result)
            }
        }
    }
    var callback : Callback<T>?
    
    init(_ callback: Callback<T>? = nil) {
        self.callback = callback
    }
    
    func then(_ callback: @escaping Callback<T>) {
        self.callback = callback
        if let result = result {
            callback(result)
        }
    }
}

public final class Promise<T> : Future<T> {
    func resolve(_ value: T) {
        result = .success(value)
    }
    func reject(_ error: Error) {
        result = .failure(error)
    }
}

import Dispatch

func asyncOperation(_ delay: Double) -> Promise<String> {
    let promise = Promise<String>()
    DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
        DispatchQueue.main.async {
            print("asyncOperation1 completed")
            promise.result = .success("Test Result")
        }
    }
    return promise
}

let future : Future<String> = asyncOperation(1.0)
future.then { result in
    switch (result) {
    case .success(let value):
        print("  Handling result: \(value)")
    case .failure(let error):
        print("  Handling error: \(error)")
    }
}

//-- CHAINING

func asyncOperation2() -> Promise<String> {
    let promise = Promise<String>()
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
        DispatchQueue.main.async {
            print("asyncOperation2 completed")
            promise.resolve("Test Result")
        }
    }
    return promise
}

func asyncOperation3(_ str : String) -> Promise<Int> {
    let promise = Promise<Int>()
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
        DispatchQueue.main.async {
            print("asyncOperation3 completed")
            promise.resolve(1000)
        }
    }
    return promise
}

func asyncOperation4(_ input : Int) -> Promise<Double> {
    let promise = Promise<Double>()
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
        DispatchQueue.main.async {
            print("asyncOperation4 completed")
            promise.reject(SimpleError.errorCause1)
        }
    }
    return promise
}

extension Future {
    func chain<Z>(_ cbk: @escaping (T) -> Future<Z>) -> Future<Z> {
        let p = Promise<Z>()
        self.then { result in
            switch result {
            case .success(let value): cbk(value).then { r in p.result = r }
            case .failure(let error): p.result = .failure(error)
            }
        }
        return p
    }
}

let promise2 = asyncOperation2()
promise2.chain { result in
    return asyncOperation3(result)
    }.chain { result in
        return asyncOperation4(result)
    }.then { result in
        print("Expected failure from ayncOperation4: \(result)")
}
