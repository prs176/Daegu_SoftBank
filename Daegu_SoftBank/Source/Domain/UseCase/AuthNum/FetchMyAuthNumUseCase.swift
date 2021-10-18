//
//  FetchMyAuthNumUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

class FetchMyAuthNumUseCase: BaseUseCase {
    let authNumRepository: AuthNumRepository
    
    init(authNumRepository: AuthNumRepository) {
        self.authNumRepository = authNumRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<Bool, Error> {
        authNumRepository.fetchMyAuthNum()
    }
}
