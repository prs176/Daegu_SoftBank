//
//  UploadRepository.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import Combine

protocol UploadRepository {
    func uploadImage(_ request: UploadRequest) -> AnyPublisher<String, Error>
}
