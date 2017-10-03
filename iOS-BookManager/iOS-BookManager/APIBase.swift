import APIKit
import Himotoki

protocol BookManagerRequest: Request {}

extension BookManagerRequest {
    var baseURL: URL {
        return URL(string: "http://54.250.239.8")!
    }
}

extension BookManagerRequest where Response: Himotoki.Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response.decodeValue(object)
    }
}
