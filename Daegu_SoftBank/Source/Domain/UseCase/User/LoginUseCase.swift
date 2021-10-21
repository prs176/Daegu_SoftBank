//
//  LoginUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

class LoginUseCase: BaseParamUseCase {
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<Void, Error> {
        userRepository.login(param.request)
    }
    
    class Param {
        let request: LoginRequest
        
        init(request: LoginRequest) {
            self.request = request
        }
        
        init(id: String, pw: String) {
            self.request = LoginRequest(id: id, pw: pw)
        }
    }
}
