//
//  AccountRepository.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

protocol AccountRepository {
    func applyAccount(_ request: AccountRequest) -> AnyPublisher<String, Error>
    
    func fetchMyAccounts() -> AnyPublisher<[Account], Error>
    
    func fetchAccountByBankAndAccount(_ bank: Int, _ account: String) -> AnyPublisher<String, Error>
    
    func fetchOtherAccounts(_ birth: String, _ name: String) -> AnyPublisher<[String], Error>
    
    func applyAddAccounts(_ request: AddAccountsRequest) -> AnyPublisher<String, Error>
    
    func fetchAccountsByPhone(_ phone: String) -> AnyPublisher<[Account], Error>
    
    func fetchAccountByAccount(_ account: String) -> AnyPublisher<Account, Error>
}
