//
//  ApplyAddAccountsUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import Combine

class ApplyAddAccountsUseCase: BaseParamUseCase {
    let accountRepository: AccountRepository
    
    init(accountRepository: AccountRepository) {
        self.accountRepository = accountRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<String, Error> {
        accountRepository.applyAddAccounts(param.request)
    }
    
    class Param {
        let request: AddAccountRequest
        
        init(request: AddAccountRequest) {
            self.request = request
        }
    }
}
