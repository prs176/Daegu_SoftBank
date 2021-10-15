//
//  TransferAPI.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Moya

enum TransferAPI {
    case postSend(_ request: TransferSendRequest)
    case postGet(_ request: TransferGetRequest)
}

extension TransferAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.DEFAULT_HOST + "transfer")!
    }
    
    var path: String {
        switch self {
        case .poseSend:
            return "/send"
        case .postGet:
            return "/get"
        }
    }
    
    var method: Method {
        switch self {
        case .poseSend:
            return .post
        case .postGet:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .poseSend(request):
            return .requestData(try! JSONEncoder().encode(request))
        case let .postGet(request):
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
        
        return headers
    }
}
