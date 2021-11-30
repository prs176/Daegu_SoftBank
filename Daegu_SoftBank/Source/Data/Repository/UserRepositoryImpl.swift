//
//  UserRepositoryImpl.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

class UserRepositoryImpl: UserRepository {
    let userRemote: UserRemote
    
    init(userRemote: UserRemote) {
        self.userRemote = userRemote
    }
    
    func register(_ request: RegisterRequest) -> AnyPublisher<Void, Error> {
        userRemote.postRegister(request)
            .map {
                AuthController.getInstance().refreshToken(token: $0)
            }
            .eraseToAnyPublisher()
    }
    
    func login(_ request: LoginRequest) -> AnyPublisher<Void, Error> {
        userRemote.postLogin(request)
            .map {
                AuthController.getInstance().login(token: $0.token, simpleId: $0.simpleId)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchMyUser() -> AnyPublisher<User, Error> {
        userRemote.getUser()
    }
    
    func fetchUserByNameAndBirth(_ name: String, _ birth: String) -> AnyPublisher<User, Error> {
        userRemote.getUserByNameAndBirth(name, birth)
    }
    
    func fetchIdCheck(_ id: String) -> AnyPublisher<Bool, Error> {
        userRemote.getIdCheck(id)
    }
    
    func fetchNickCheck(_ nick: String) -> AnyPublisher<Bool, Error> {
        userRemote.getNickCheck(nick)
    }
}
