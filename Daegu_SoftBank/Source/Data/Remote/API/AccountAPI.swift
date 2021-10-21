//
//  AccountAPI.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Moya

enum AccountAPI {
    case postAccount(_ request: AccountRequest)
    case getAccounts
    case getAccountsByPhone(_ phone: String)
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
        case .getAccounts:
            return ""
        case let .getAccountsByPhone(phone):
            return "/\(phone)"
        case let .getAccountByAccount(account):
            return "/account/\(account)"
        }
    }
    
    var method: Method {
        switch self {
        case .postAccount:
            return .post
        case .getAccounts:
            return .get
        case .getAccountsByPhone:
            return .get
        case .getAccountByAccount:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .postAccount(request):
            return .requestData(try! JSONEncoder().encode(request))
        case .getAccounts:
            return .requestPlain
        case .getAccountsByPhone:
            return .requestPlain
        case .getAccountByAccount:
            return .requestPlain
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
