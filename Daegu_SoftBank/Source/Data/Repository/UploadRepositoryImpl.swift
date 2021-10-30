//
//  UploadRepositoryImpl.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import Combine

class UploadRepositoryImpl: UploadRepository {
    let uploadRemote: UploadRemote
    
    init(uploadRemote: UploadRemote) {
        self.uploadRemote = uploadRemote
    }
    
    func uploadImage(_ request: UploadRequest) -> AnyPublisher<String, Error> {
        uploadRemote.postUpload(request)
    }
}
