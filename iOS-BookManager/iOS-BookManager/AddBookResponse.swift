import APIKit
import Himotoki

struct AddBookResponse: Decodable {
    // 新規登録された書籍のID番号をresponseとして表示
    let result: Book
    static func decode(_ e: Extractor) throws -> AddBookResponse {
        return try AddBookResponse(result: e <| "result")
    }
}
