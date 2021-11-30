//
//  FetchMyAccountsUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/19.
//

import Combine

class FetchMyAccountsUseCase: BaseUseCase {
    let accountRepository: AccountRepository
    
    init(accountRepository: AccountRepository) {
        self.accountRepository = accountRepository
    }
    
    func buildUseCasePublisher() -> AnyPublisher<([Account], [OtherAccount]), Error> {
        accountRepository.fetchMyAccounts()
    }
}
