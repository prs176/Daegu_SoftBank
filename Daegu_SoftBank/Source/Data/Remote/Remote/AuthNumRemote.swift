//
//  AuthNumRemote.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/15.
//

import Combine

class AuthNumRemote: BaseRemote<AuthNumAPI> {
    func postAuthNum(_ request: AuthNumRequest) -> AnyPublisher<String, Error> {
        return self.request(.postAuthNum(request))
            .map(MessageResponse.self, using: decoder)
            .map { $0.message }
            .eraseToAnyPublisher()
    }
    
    func getAuthNum() -> AnyPublisher<Bool, Error> {
        return self.request(.getAuthNum)
            .map(Response<AuthNumData>.self, using: decoder)
            .map { $0.data.isHave }
            .eraseToAnyPublisher()
    }
    
    func postAuthNumLogin(_ request: LoginRequest) -> AnyPublisher<String, Error> {
        return self.request(.postAuthNumLogin(request))
            .map(Response<AuthNumLoginData>.self, using: decoder)
            .map { $0.data.token }
            .eraseToAnyPublisher()
    }
}
