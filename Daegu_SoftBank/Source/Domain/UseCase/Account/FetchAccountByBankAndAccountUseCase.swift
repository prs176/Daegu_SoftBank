//
//  FetchAccountByBankAndAccountUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/03.
//

import Combine

class FetchAccountByBankAndAccountUseCase: BaseParamUseCase {
    let accountRepository: AccountRepository
    
    init(accountRepository: AccountRepository) {
        self.accountRepository = accountRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<String, Error> {
        accountRepository.fetchAccountByBankAndAccount(param.bank, param.account)
    }
    
    class Param {
        let bank: Int
        let account: String
        
        init(bank: Int, account: String) {
            self.bank = bank
            self.account = account
        }
    }
}
