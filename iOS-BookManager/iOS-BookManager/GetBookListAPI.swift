import APIKit
import Himotoki

struct GetBookListRequest: BMRequest {
    typealias Response = GetBookListResponse
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/books"
    }
    
    var headerFields: [String : String] {
        return ["Content-Type": "application/json",
                "Authorization": UserDefaults.standard.string(forKey: "token")!
        ]
    }
    
    let limit: Int
    let page: Int
    
    var parameters: Any? {
        return [
            "limit": self.limit,
            "page": self.page
        ]
    }
    
}

struct GetBookListResponse: Decodable {
    let result: [Book]
    static func decode(_ e: Extractor) throws -> GetBookListResponse {
        return try GetBookListResponse(result: e <|| "result")
    }
}
