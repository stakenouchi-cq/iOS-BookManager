import APIKit
import Himotoki

struct EditBookRequest: BookManagerRequest {
    typealias Response = EditBookResponse
    
    let id: Int
    let name: String
    let image: String
    let price: Int
    let purchaseDate: String
    
    var method: HTTPMethod {
        return .put
    }
    
    var path: String {
        return "/books/\(id)"
    }
    
    var headerFields: [String : String] {
        return ["Content-Type": "application/json",
                "Authorization": UserDefaults.standard.string(forKey: "token")!
        ]
    }
    
    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "name": name,
            "image": image,
            "price": price,
            "purchase_date": purchaseDate
            ])
    }
    
}
