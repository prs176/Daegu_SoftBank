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
    
    func applyAccount(_ request: AccountRequest) -> AnyPublisher<AccountInfo, Error> {
        accountRemote.postAccount(request)
    }
    
    func fetchMyAccounts() -> AnyPublisher<[Account], Error> {
        accountRemote.getAccounts()
    }
    
    func fetchAccountByBankAndAccount(_ bank: Int, _ account: String) -> AnyPublisher<Account, Error> {
        accountRemote.getAccountByBankAndAccount(bank, account)
    }
    
    func fetchOtherAccounts(_ birth: String, _ name: String) -> AnyPublisher<[Account], Error> {
        accountRemote.getOtherAccounts(birth, name)
    }
    
    func applyAddAccounts(_ request: AddAccountsRequest) -> AnyPublisher<String, Error> {
        accountRemote.postAddAccounts(request)
    }
    
    func fetchAccountsByPhone(_ phone: String) -> AnyPublisher<[Account], Error> {
        accountRemote.getAccountsByPhone(phone)
    }
    
    func fetchAccountByAccount(_ account: String) -> AnyPublisher<Account, Error> {
        accountRemote.getAccountByAccount(account)
    }
}
