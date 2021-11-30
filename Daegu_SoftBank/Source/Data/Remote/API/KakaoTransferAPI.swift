//
//  KakaoTransferAPI.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/30.
//

import Moya

enum KakaoTransferAPI {
    case postTransferSend(_ request: KakaoTransferSendRequest)
    case postTransferGet(_ request: KakaoTransferGetRequest)
}

extension KakaoTransferAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.KAKAO_HOST + "remittance")!
    }
    
    var path: String {
        switch self {
        case .postTransferSend:
            return "/send"
        case .postTransferGet:
            return "/recieve"
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
        var headers = ["Content-Type": "multipart/form-data"]
        headers["authorization"] = AuthController.getInstance().getToken()
        
        return headers
    }
}


