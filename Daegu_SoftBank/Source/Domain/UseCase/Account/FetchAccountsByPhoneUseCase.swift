//
//  FetchAccountsByPhoneUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/19.
//

import Combine

class FetchAccountsByPhoneUseCase: BaseParamUseCase {
    let accountRepository: AccountRepository
    
    init(accountRepository: AccountRepository) {
        self.accountRepository = accountRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<[Account], Error> {
        accountRepository.fetchAccountsByPhone(param.phone)
    }
    
    class Param {
        let phone: String
        
        init(phone: String) {
            self.phone = phone
        }
    }
}
