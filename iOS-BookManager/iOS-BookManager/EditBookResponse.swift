import APIKit
import Himotoki

struct EditBookResponse: Himotoki.Decodable {
    let result: Book
    static func decode(_ e: Extractor) throws -> EditBookResponse {
        return try EditBookResponse(result: e <| "result")
    }
}
