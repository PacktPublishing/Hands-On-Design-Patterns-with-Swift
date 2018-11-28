// FuturesAndPromises
// Types

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

public typealias Callback<T> = (Result<T>) -> Void
