//
//  AuthNumRepositoryImpl.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

class AuthNumRepositoryImpl: AuthNumRepository {
    let authNumRemote: AuthNumRemote
    
    init(authNumRemote: AuthNumRemote) {
        self.authNumRemote = authNumRemote
    }
    
    func applyAuthNum(_ request: AuthNumRequest) -> AnyPublisher<String, Error> {
        authNumRemote.postAuthNum(request)
    }
    
    func fetchMyAuthNum() -> AnyPublisher<Bool, Error> {
        authNumRemote.getAuthNum()
    }
    
    func loginByAuthNum(_ request: LoginRequest) -> AnyPublisher<Void, Error> {
        authNumRemote.postAuthNumLogin(request)
            .map {
                AuthController.getInstance().refreshToken(token: $0)
            }
            .eraseToAnyPublisher()
    }
}
