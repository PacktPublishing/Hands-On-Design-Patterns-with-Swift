import Foundation

public func get<T: Decodable>(url: URL,
                completion: @escaping(_ data: T?, _ error: Error?) -> Void) -> Void {
    jsonRequest(urlRequest: URLRequest(url: url), completion: completion)
}

public func post<T: Encodable, U: Decodable>(url: URL, body: T,
                                             completion: @escaping (_ data: U?, _ error: Error?) -> Void) -> Void {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try? JSONEncoder().encode(body)
    jsonRequest(urlRequest: request, completion: completion)
}

private func jsonRequest<T: Decodable>(urlRequest: URLRequest,
                               completion: @escaping (_ data: T?, _ error: Error?) -> Void) -> Void {
    let d = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        let d = try? JSONDecoder().decode(T.self, from: data!)
        completion(d, error)
    }
    d.resume()
}


