import APIKit
import Himotoki

struct AddBookRequest: BMRequest {
    typealias Response = AddBookResponse
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/books"
    }
    
    var headerFields: [String : String] {
        return ["Content-Type": "application/json",
                "Authorization": UserDefaults.standard.string(forKey: "token")!
        ]
    }
    
    let name: String
    let image: String
    let price: Int
    let purchaseDate: String
    
    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "name": name,
            "image": image,
            "price": price,
            "purchase_date": purchaseDate
            ])
    }
    
}

struct AddBookResponse: Decodable {
    // 新規登録された書籍のID番号をresponseとして表示
    let result: Book
    static func decode(_ e: Extractor) throws -> AddBookResponse {
        return try AddBookResponse(result: e <| "result")
    }
}
