//
//  RemoteAssembly.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/21.
//

import Swinject

class RemoteAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UserRemote.self) { _ in
            UserRemote()
        }
        .inObjectScope(.container)
        
        container.register(AuthNumRemote.self) { _ in
            AuthNumRemote()
        }
        .inObjectScope(.container)
        
        container.register(AccountRemote.self) { _ in
            AccountRemote()
        }
        .inObjectScope(.container)
        
        container.register(TransferRemote.self) { _ in
            TransferRemote()
        }
        .inObjectScope(.container)
        
        container.register(KakaoTransferRemote.self) { _ in
            KakaoTransferRemote()
        }
        .inObjectScope(.container)
        
        container.register(UploadRemote.self) { _ in
            UploadRemote()
        }
        .inObjectScope(.container)
    }
}
