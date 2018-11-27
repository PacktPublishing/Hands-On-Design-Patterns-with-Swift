// FuturesAndPromises
// Promise

public final class Promise<T> : Future<T> {

    public func resolve(_ value: T) {
        result = .success(value)
    }
    public func reject(_ error: Error) {
        result = .failure(error)
    }
}
