//
//  ApplyAccountUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/19.
//

import Combine

class ApplyAccountUseCase: BaseParamUseCase {
    let accountRepository: AccountRepository
    
    init(accountRepository: AccountRepository) {
        self.accountRepository = accountRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<AccountInfo, Error> {
        accountRepository.applyAccount(param.request)
    }
    
    class Param {
        let request: AccountRequest
        
        init(request: AccountRequest) {
            self.request = request
        }
        
        init(
            accountPW: String,
            name: String,
            birth: String
        ) {
            self.request = AccountRequest(
                accountPW: accountPW,
                name: name,
                birth: birth
            )
        }
    }
}
