import APIKit
import Himotoki

struct LogoutRequest: BookManagerRequest {
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
    
}
