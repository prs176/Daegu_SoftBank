//
//  AuthNumAPI.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Moya

enum AuthNumAPI {
    case postAuthNum(_ request: AuthNumRequest)
    case getAuthNum
    case postAuthNumLogin(_ request: LoginRequest)
}

extension AuthNumAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.DEFAULT_HOST + "password")!
    }
    
    var path: String {
        switch self {
        case .postAuthNum:
            return ""
        case .getAuthNum:
            return ""
        case .postAuthNumLogin:
            return "/login"
        }
    }
    
    var method: Method {
        switch self {
        case .postAuthNum:
            return .post
        case .getAuthNum:
            return .get
        case .postAuthNumLogin:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .postAuthNum(request):
            return .requestData(try! JSONEncoder().encode(request))
        case .getAuthNum:
            return .requestPlain
        case let .postAuthNumLogin(request):
            return .requestData(try! JSONEncoder().encode(request))
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        var headers = ["Content-Type": "application/json"]
        headers["x-access-token"] = AuthController.getInstance().getToken()
        
        return headers
    }
}
