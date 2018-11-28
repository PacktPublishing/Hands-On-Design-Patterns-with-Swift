// FuturesAndPromises
// Future

public class Future<T> {

    internal var result : Result<T>? {
        didSet {
            if let result = result, let callback = callback {
                callback(result)
            }
        }
    }
    var callback : Callback<T>?
    
    public init(_ callback: Callback<T>? = nil) {
        self.callback = callback
    }
    
    public func then(_ callback: @escaping Callback<T>) {
        self.callback = callback
        if let result = result {
            callback(result)
        }
    }
}
