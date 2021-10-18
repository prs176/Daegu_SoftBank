//
//  UserAPI.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Moya

enum UserAPI {
    case postRegister(_ request: RegisterRequest)
    case postLogin(_ request: LoginRequest)
    case getUser
    case getUserByNameAndBirth(_ name: String, _ birth: String)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.DEFAULT_HOST + "user")!
    }
    
    var path: String {
        switch self {
        case .postRegister:
            return "/register"
        case .postLogin:
            return "/login"
        case .getUser:
            return ""
        case .getUserByNameAndBirth:
            return "/get"
        }
    }
    
    var method: Method {
        switch self {
        case .postRegister:
            return .post
        case .postLogin:
            return .post
        case .getUser:
            return .get
        case .getUserByNameAndBirth:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .postRegister(request):
            return .requestData(try! JSONEncoder().encode(request))
        case let .postLogin(request):
            return .requestData(try! JSONEncoder().encode(request))
        case .getUser:
            return .requestPlain
        case let .getUserByNameAndBirth(name, birth):
            return .requestParameters(parameters: ["name": name, "birth": birth], encoding: URLEncoding.queryString)
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
