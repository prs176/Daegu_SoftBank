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
    
    func fetchAccountsByPhone(_ phone: String) -> AnyPublisher<[Account], Error>
    
    func fetchAccountByAccount(_ account: String) -> AnyPublisher<Account, Error>
}
