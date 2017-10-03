import APIKit
import Himotoki

struct User: Himotoki.Decodable {
    var id: Int
    var email: String
    var token: String
    
    static func decode(_ e: Extractor) throws -> User {
        return try User(
            id: e <| ["result", "id"],
            email: e <| ["result", "email"],
            token: e <| ["result", "token"]
        )
    }
}
