import APIKit
import Himotoki

struct SignupRequest: BMRequest {
    typealias Response = User
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/sign_up"
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
