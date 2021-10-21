//
//  ApplyAuthNumUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

class ApplyAuthNumUseCase: BaseParamUseCase {
    let authNumRepository: AuthNumRepository
    
    init(authNumRepository: AuthNumRepository) {
        self.authNumRepository = authNumRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<String, Error> {
        authNumRepository.applyAuthNum(param.request)
    }
    
    class Param {
        let request: AuthNumRequest
        
        init(request: AuthNumRequest) {
            self.request = request
        }
        
        init(pw: String) {
            self.request = AuthNumRequest(pw: pw)
        }
    }
}
