//
//  FetchAccountByAccountUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/19.
//

import Combine

class FetchAccountByAccountUseCase: BaseParamUseCase {
    let accountRepository: AccountRepository
    
    init(accountRepository: AccountRepository) {
        self.accountRepository = accountRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<Account, Error> {
        accountRepository.fetchAccountByAccount(param.account)
    }
    
    class Param {
        let account: String
        
        init(account: String) {
            self.account = account
        }
    }
}
