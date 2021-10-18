//
//  FetchMyUserUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

class FetchMyUserUseCase: BaseUseCase {
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func buildUseCasePublisher() -> AnyPublisher<User, Error> {
        userRepository.fetchMyUser()
    }
}
