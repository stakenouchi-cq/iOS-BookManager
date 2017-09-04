import APIKit
import Himotoki

struct LogoutRequest: BMRequest {
    typealias Response = User
    
    var method: HTTPMethod {
        return .delete
    }
    
    var path: String {
        return "/logout"
    }
    
    var headerFields: [String : String] {
        return ["Content-Type": "application/json",
        "Authorization": UserDefaults.standard.string(forKey: "token")!
        ]
    }
    
    let token: String
    
    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "token": token
        ])
    }
    
}
