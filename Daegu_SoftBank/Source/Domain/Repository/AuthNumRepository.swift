//
//  AuthNumRepository.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

protocol AuthNumRepository {
    func applyAuthNum(_ request: AuthNumRequest) -> AnyPublisher<String, Error>
    
    func fetchMyAuthNum() -> AnyPublisher<Bool, Error>
    
    func loginByAuthNum(_ request: LoginRequest) -> AnyPublisher<Void, Error>
}
