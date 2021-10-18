//
//  AccountRepositoryImpl.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

class AccountRepositoryImpl: AccountRepository {
    let accountRemote: AccountRemote
    
    init(accountRemote: AccountRemote) {
        self.accountRemote = accountRemote
    }
    
    func applyAccount(_ request: AccountRequest) -> AnyPublisher<String, Error> {
        accountRemote.postAccount(request)
    }
    
    func fetchMyAccount() -> AnyPublisher<[Account], Error> {
        accountRemote.getAccount()
    }
    
    func fetchAccountByPhone(_ phone: String) -> AnyPublisher<[Account], Error> {
        accountRemote.getAccountByPhone(phone)
    }
    
    func fetchAccountByAccount(_ account: String) -> AnyPublisher<[Account], Error> {
        accountRemote.getAccountByAccount(account)
    }
}
