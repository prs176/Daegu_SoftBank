//
//  TransferAPI.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Moya

enum TransferAPI {
    case postTransferSend(_ request: TransferSendRequest)
    case postTransferGet(_ request: TransferGetRequest)
}

extension TransferAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.DEFAULT_HOST + "transfer")!
    }
    
    var path: String {
        switch self {
        case .postTransferSend:
            return "/send"
        case .postTransferGet:
            return "/take"
        }
    }
    
    var method: Method {
        switch self {
        case .postTransferSend:
            return .post
        case .postTransferGet:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .postTransferSend(request):
            return .requestData(try! JSONEncoder().encode(request))
        case let .postTransferGet(request):
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
        headers["authorization"] = AuthController.getInstance().getToken()
        
        return headers
    }
}
