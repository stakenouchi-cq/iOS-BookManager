import APIKit
import Himotoki

struct GetBookListRequest: BMRequest {
    typealias Response = User
    
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
    
    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "limit": limit,
            "page": page
            ])
    }
    
}
