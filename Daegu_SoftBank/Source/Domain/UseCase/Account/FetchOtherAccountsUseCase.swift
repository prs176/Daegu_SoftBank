//
//  FetchOtherAccountsUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import Combine

class FetchOtherAccountsUseCase: BaseUseCase {
    let accountRepository: AccountRepository
    
    init(accountRepository: AccountRepository) {
        self.accountRepository = accountRepository
    }
    
    func buildUseCasePublisher() -> AnyPublisher<[String], Error> {
        accountRepository.fetchOtherAccounts()
    }
}
