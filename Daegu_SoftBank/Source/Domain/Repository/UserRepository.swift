//
//  UserRepository.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

protocol UserRepository {
    func register(_ request: RegisterRequest) -> AnyPublisher<Void, Error>
    
    func login(_ request: LoginRequest) -> AnyPublisher<Void, Error>
    
    func fetchMyUser() -> AnyPublisher<User, Error>
    
    func fetchUser(_ name: String, _ birth: String) -> AnyPublisher<User, Error>
}
