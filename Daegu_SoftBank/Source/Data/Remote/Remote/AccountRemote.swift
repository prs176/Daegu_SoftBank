//
//  AccountRemote.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/15.
//

import Combine

class AccountRemote: BaseRemote<AccountAPI> {
    func postAccount(_ request: AccountRequest) -> AnyPublisher<String, Error> {
        return self.request(.postAccount(request))
            .map(Response<AccountData>.self, using: decoder)
            .map { $0.data.account }
            .eraseToAnyPublisher()
    }
    
    func getAccount() -> AnyPublisher<[Account], Error> {
        return self.request(.getAccount)
            .map(Response<[Account]>.self, using: decoder)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    func getAccountByPhone(_ phone: String) -> AnyPublisher<[Account], Error> {
        return self.request(.getAccountByPhone(phone))
            .map(Response<[Account]>.self, using: decoder)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    func getAccountByAccount(_ account: String) -> AnyPublisher<[Account], Error> {
        return self.request(.getAccountByAccount(account))
            .map(Response<[Account]>.self, using: decoder)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
