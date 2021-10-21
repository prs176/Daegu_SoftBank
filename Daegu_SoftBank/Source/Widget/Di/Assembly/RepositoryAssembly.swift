//
//  RepositoryAssembly.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/21.
//

import Swinject

class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UserRepository.self) { r in
            UserRepositoryImpl(userRemote: r.resolve(UserRemote.self)!)
        }
        .inObjectScope(.container)
        
        container.register(AuthNumRepository.self) { r in
            AuthNumRepositoryImpl(authNumRemote: r.resolve(AuthNumRemote.self)!)
        }
        .inObjectScope(.container)
    
        container.register(AccountRepository.self) { r in
            AccountRepositoryImpl(accountRemote: r.resolve(AccountRemote.self)!)
        }
        .inObjectScope(.container)
    
        container.register(TransferRepository.self) { r in
            TransferRepositoryImpl(transferRemote: r.resolve(TransferRemote.self)!)
        }
        .inObjectScope(.container)
    }
}
