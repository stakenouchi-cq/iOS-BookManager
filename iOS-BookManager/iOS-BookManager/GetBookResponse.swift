import APIKit
import Himotoki

struct GetBookResponse: Himotoki.Decodable {
    let result: [Book]
    static func decode(_ e: Extractor) throws -> GetBookResponse {
        return try GetBookResponse(result: e <|| "result")
    }
}
