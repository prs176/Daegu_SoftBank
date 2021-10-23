//
//  FetchIdCheckUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/23.
//

import Combine

class FetchIdCheckUseCase: BaseParamUseCase {
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<Bool, Error> {
        userRepository.fetchIdCheck(param.id)
    }
    
    class Param {
        let id: String
        
        init(id: String) {
            self.id = id
        }
    }
}
