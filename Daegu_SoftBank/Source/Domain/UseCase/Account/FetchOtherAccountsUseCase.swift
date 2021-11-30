//
//  FetchOtherAccountsUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import Combine

class FetchOtherAccountsUseCase: BaseParamUseCase {
    let accountRepository: AccountRepository
    
    init(accountRepository: AccountRepository) {
        self.accountRepository = accountRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<[Account], Error> {
        accountRepository.fetchOtherAccounts(param.birth, param.name)
    }
    
    class Param {
        let birth: String
        let name: String
        
        init(
            birth: String,
            name: String
        ) {
            self.birth = birth
            self.name = name
        }
    }
}
