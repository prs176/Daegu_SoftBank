//
//  UploadUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import Combine
import UIKit

class UploadUseCase: BaseParamUseCase {
    let uploadRepository: UploadRepository
    
    init(uploadRepository: UploadRepository) {
        self.uploadRepository = uploadRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<String, Error> {
        uploadRepository.uploadImage(param.request)
    }
    
    class Param {
        let request: UploadRequest
        
        init(request: UploadRequest) {
            self.request = request
        }
        
        init(
            type: ImageType,
            name: String,
            image: UIImage?
        ) {
            self.request = UploadRequest(
                type: type,
                name: name,
                image: image
            )
        }
    }
}
