//
//  RegisterUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

class RegisterUseCase: BaseParamUseCase {
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<Void, Error> {
        userRepository.register(param.request)
    }
    
    class Param {
        let request: RegisterRequest
        
        init(request: RegisterRequest) {
            self.request = request
        }
        
        init(id: String, pw: String, nick: String, phone: String, birth: String) {
            self.request = RegisterRequest(id: id, pw: pw, nick: nick, phone: phone, birth: birth)
        }
    }
}
