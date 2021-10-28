//
//  UploadRemote.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import Moya
import Combine

class UploadRemote: BaseRemote<UploadAPI> {
    func postUpload(_ request: UploadRequest) -> AnyPublisher<String, Error> {
        guard let multipartFormData = getMultipartFormData(request) else {
            return Future<String, Error> {
                $0(.failure(SoftBankError.error(message: "지원하지 않는 이미지 형식입니다.")))
            }
            .eraseToAnyPublisher()
        }
        
        return self.request(.postUpload(multipartFormData))
            .map(Response<UploadResponse>.self, using: decoder)
            .map { $0.data.files.first ?? "" }
            .eraseToAnyPublisher()
    }
}

extension UploadRemote {
    func getMultipartFormData(_ request: UploadRequest) -> [MultipartFormData]? {
        guard let image = request.image else {
            return []
        }
        
        var imgData: Data? = nil
        switch request.type {
        case .JPG:
            imgData = image.jpegData(compressionQuality: 0.2)
            break
        case .PNG:
            imgData = image.pngData()
            break
        case .UNKNOWN:
            return nil
        }
        
        let multipartFormData: MultipartFormData = MultipartFormData(
            provider: .data(imgData!),
            name: "images",
            fileName: request.name,
            mimeType: request.type.mimeType
        )
        
        return [multipartFormData]
    }
}
