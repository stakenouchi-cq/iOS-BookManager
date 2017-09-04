import APIKit
import Himotoki

struct LoginRequest: BMRequest {
    typealias Response = User
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/login"
    }
    
    var headerFields: [String : String] {
        return ["Content-Type": "application/json"]
    }
    
    let email: String
    let password: String
    
    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "email": email,
            "password": password
        ])
    }
    
}
