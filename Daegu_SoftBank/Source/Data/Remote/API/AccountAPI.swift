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
    case getAccountByBankAndAccount(_ bank: Int, _ account: String)
    case getOtherAccounts(_ birth: String, _ name: String)
    case postAddAccounts(_ request: AddAccountsRequest)
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
        case .getAccountByBankAndAccount(let bank, _):
            return "/other2/\(bank)"
        case .getOtherAccounts:
            return "/other"
        case .postAddAccounts:
            return "/add"
        case let .getAccountsByPhone(phone):
            return "/\(phone)"
        case let .getAccountByAccount(account):
            return "/\(account)"
        }
    }
    
    var method: Method {
        switch self {
        case .postAccount:
            return .post
        case .getAccounts:
            return .get
        case .getAccountByBankAndAccount:
            return . get
        case .getOtherAccounts:
            return .get
        case .postAddAccounts:
            return .post
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
        case .getAccountByBankAndAccount(_, let account):
            return .requestParameters(parameters: ["account": account], encoding: URLEncoding.queryString)
        case let .getOtherAccounts(birth, name):
            return .requestParameters(parameters: ["birth": birth, "name": name], encoding: URLEncoding.queryString)
        case let .postAddAccounts(request):
            return .requestData(try! JSONEncoder().encode(request))
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
