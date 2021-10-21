//
//  UseCaseAssembly.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/21.
//

import Swinject

class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        // MARK: User
        container.register(RegisterUseCase.self) { r in
            RegisterUseCase(userRepository: r.resolve(UserRepository.self)!)
        }
        
        container.register(LoginUseCase.self) { r in
            LoginUseCase(userRepository: r.resolve(UserRepository.self)!)
        }
        
        container.register(FetchMyUserUseCase.self) { r in
            FetchMyUserUseCase(userRepository: r.resolve(UserRepository.self)!)
        }
        
        container.register(FetchUserByNameAndBirth.self) { r in
            FetchUserByNameAndBirth(userRepository: r.resolve(UserRepository.self)!)
        }
        
        // MARK: AuthNum
        container.register(ApplyAuthNumUseCase.self) { r in
            ApplyAuthNumUseCase(authNumRepository: r.resolve(AuthNumRepository.self)!)
        }
        
        container.register(FetchMyAuthNumUseCase.self) { r in
            FetchMyAuthNumUseCase(authNumRepository: r.resolve(AuthNumRepository.self)!)
        }
        
        container.register(LoginByAuthNumUseCase.self) { r in
            LoginByAuthNumUseCase(authNumRepository: r.resolve(AuthNumRepository.self)!)
        }
        
        // MARK: Account
        container.register(ApplyAccountUseCase.self) { r in
            ApplyAccountUseCase(accountRepository: r.resolve(AccountRepository.self)!)
        }
        
        container.register(FetchMyAccountsUseCase.self) { r in
            FetchMyAccountsUseCase(accountRepository: r.resolve(AccountRepository.self)!)
        }
        
        container.register(FetchAccountsByPhoneUseCase.self) { r in
            FetchAccountsByPhoneUseCase(accountRepository: r.resolve(AccountRepository.self)!)
        }
        
        container.register(FetchAccountByAccountUseCase.self) { r in
            FetchAccountByAccountUseCase(accountRepository: r.resolve(AccountRepository.self)!)
        }
        
        // MARK: Transfer
        container.register(TransferSendUseCase.self) { r in
            TransferSendUseCase(transferRepository: r.resolve(TransferRepository.self)!)
        }
    }
}
