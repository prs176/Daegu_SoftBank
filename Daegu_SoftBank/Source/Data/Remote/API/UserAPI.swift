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
    case getIdCheck(_ id: String)
    case getNickCheck(_ nick: String)
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
        case .getIdCheck:
            return "/check-id"
        case .getNickCheck:
            return "/check-nick"
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
        case .getIdCheck:
            return .get
        case .getNickCheck:
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
        case let .getIdCheck(id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.queryString)
        case let .getNickCheck(nick):
            return .requestParameters(parameters: ["nick": nick], encoding: URLEncoding.queryString)
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
        headers["authorization"] = AuthController.getInstance().getToken()
        
        return headers
    }
}
