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
    
    func getAccounts() -> AnyPublisher<[Account], Error> {
        return self.request(.getAccounts)
            .map(Response<[Account]>.self, using: decoder)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    func getAccountByBankAndAccount(_ bank: Int, _ account: String) -> AnyPublisher<Account, Error> {
        return self.request(.getAccountByBankAndAccount(bank, account))
            .map(Response<Account>.self, using: decoder)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    func getOtherAccounts(_ birth: String, _ name: String) -> AnyPublisher<[String], Error> {
        return self.request(.getOtherAccounts(birth, name))
            .map(Response<[String]>.self, using: decoder)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    func postAddAccounts(_ request: AddAccountsRequest) -> AnyPublisher<String, Error> {
        return self.request(.postAddAccounts(request))
            .map(MessageResponse.self, using: decoder)
            .map { $0.message }
            .eraseToAnyPublisher()
    }
    
    func getAccountsByPhone(_ phone: String) -> AnyPublisher<[Account], Error> {
        return self.request(.getAccountsByPhone(phone))
            .map(Response<[Account]>.self, using: decoder)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    func getAccountByAccount(_ account: String) -> AnyPublisher<Account, Error> {
        return self.request(.getAccountByAccount(account))
            .map(Response<Account>.self, using: decoder)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
