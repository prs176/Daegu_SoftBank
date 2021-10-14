//
//  AccountAPI.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Moya

enum AccountAPI {
    case postAccount(_ request: AccountRequest)
    case getAccount
    case getAccountByPhone(_ phone: String)
    case getAccountByAccount(_ account: String)
}

extension AccountAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.DEFAULT_HOST + "account")!
    }
    
    var path: String {
        switch self {
        case .postAccount:
            return ""
        case .getAccount:
            return ""
        case let .getAccountByPhone(phone):
            return "/\(phone)"
        case .getAccountByAccount:
            return "/account"
        }
    }
    
    var method: Method {
        switch self {
        case .postAccount:
            return .post
        case .getAccount:
            return .get
        case .getAccountByPhone:
            return .get
        case .getAccountByAccount:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
    var task: Task {
        switch self {
        case let .postAccount(request):
            return .requestData(try! JSONEncoder().encode(request))
        case .getAccount:
            return .requestPlain
        case .getAccountByPhone:
            return .requestPlain
        case let .getAccountByAccount(account):
            return .requestParameters(parameters: ["account": account], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        var headers = ["Content-Type": "application/json"]
        
        return headers
    }
}
