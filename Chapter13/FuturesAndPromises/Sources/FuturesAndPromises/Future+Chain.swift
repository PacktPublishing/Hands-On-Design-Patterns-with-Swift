// FuturesAndPromises
// Future+Chain

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
