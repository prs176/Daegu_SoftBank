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
    
    func fetchUserByNameAndBirth(_ name: String, _ birth: String) -> AnyPublisher<User, Error>
    
    func fetchIdCheck(_ id: String) -> AnyPublisher<Bool, Error>
    
    func fetchNickCheck(_ nick: String) -> AnyPublisher<Bool, Error>
}
