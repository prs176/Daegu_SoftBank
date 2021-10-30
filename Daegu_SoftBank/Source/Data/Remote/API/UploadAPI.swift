//
//  UploadAPI.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import Moya

enum UploadAPI {
    case postUpload(_ image: [MultipartFormData])
}

extension UploadAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.DEFAULT_HOST + "upload")!
    }
    
    var path: String {
        switch self {
        case .postUpload:
            return ""
        }
    }
    
    var method: Method {
        switch self {
        case .postUpload:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .postUpload(image):
            return .uploadMultipart(image)
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


