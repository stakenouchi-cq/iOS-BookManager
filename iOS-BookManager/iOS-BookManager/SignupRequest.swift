import APIKit
import Himotoki

struct SignupRequest: BookManagerRequest {
    typealias Response = User
    
    let email: String
    let password: String
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/sign_up"
    }
    
    var headerFields: [String : String] {
        return ["Content-Type": "application/json"]
    }
    
    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "email": email,
            "password": password
        ])
    }
    
}
