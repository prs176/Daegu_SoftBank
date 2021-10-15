//
//  UserRemote.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/15.
//

import Combine

class UserRemote: BaseRemote<UserAPI> {
    func postRegister(_ request: RegisterRequest) -> AnyPublisher<String, Error> {
        return self.request(.postRegister(request))
            .map(Response<RegisterData>.self, using: decoder)
            .map { $0.data.token }
            .eraseToAnyPublisher()
    }
    
    func postLogin(_ request: LoginRequest) -> AnyPublisher<LoginRequest, Error> {
        return self.request(.postLogin(request))
            .map(Response<LoginRequest>.self, using: decoder)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    func getUser() -> AnyPublisher<User, Error> {
        return self.request(.getUser)
            .map(Response<User>.self, using: decoder)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
