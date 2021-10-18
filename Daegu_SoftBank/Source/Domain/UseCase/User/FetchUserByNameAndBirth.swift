//
//  FetchUserByNameAndBirth.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

class FetchUserByNameAndBirth: BaseParamUseCase {
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<User, Error> {
        userRepository.fetchUserByNameAndBirth(param.name, param.birth)
    }
    
    class Param {
        let name: String
        let birth: String
        
        init(name: String, birth: String) {
            self.name = name
            self.birth = birth
        }
    }
}
