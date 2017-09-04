import APIKit
import Himotoki

protocol BMRequest: Request {}

extension BMRequest {
    var baseURL: URL {
        return URL(string: "http://54.250.239.8")!
    }
}

extension BMRequest where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response.decodeValue(object)
    }
}
