//
//  LoginByAuthNumUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

class LoginByAuthNumUseCase: BaseParamUseCase {
    let authNumRepository: AuthNumRepository
    
    init(authNumRepository: AuthNumRepository) {
        self.authNumRepository = authNumRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<Void, Error> {
        authNumRepository.loginByAuthNum(param.request)
    }
    
    class Param {
        let request: LoginRequest
        
        init(request: LoginRequest) {
            self.request = request
        }
        
        init(pw: String) {
            self.request = LoginRequest(id: AuthController.getInstance().getSimpleId(), pw: pw)
        }
    }
}
