//
//  FetchNickCheckUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/23.
//

import Combine

class FetchNickCheckUseCase: BaseParamUseCase {
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<Bool, Error> {
        userRepository.fetchNickCheck(param.nick)
    }
    
    class Param {
        let nick: String
        
        init(nick: String) {
            self.nick = nick
        }
    }
}
