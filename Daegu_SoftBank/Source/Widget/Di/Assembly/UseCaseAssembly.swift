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
        .inObjectScope(.container)
        
        container.register(LoginUseCase.self) { r in
            LoginUseCase(userRepository: r.resolve(UserRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FetchMyUserUseCase.self) { r in
            FetchMyUserUseCase(userRepository: r.resolve(UserRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FetchUserByNameAndBirthUseCase.self) { r in
            FetchUserByNameAndBirthUseCase(userRepository: r.resolve(UserRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FetchIdCheckUseCase.self) { r in
            FetchIdCheckUseCase(userRepository: r.resolve(UserRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FetchNickCheckUseCase.self) { r in
            FetchNickCheckUseCase(userRepository: r.resolve(UserRepository.self)!)
        }
        .inObjectScope(.container)
        
        // MARK: AuthNum
        container.register(ApplyAuthNumUseCase.self) { r in
            ApplyAuthNumUseCase(authNumRepository: r.resolve(AuthNumRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FetchMyAuthNumUseCase.self) { r in
            FetchMyAuthNumUseCase(authNumRepository: r.resolve(AuthNumRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(LoginByAuthNumUseCase.self) { r in
            LoginByAuthNumUseCase(authNumRepository: r.resolve(AuthNumRepository.self)!)
        }
        .inObjectScope(.container)
        
        // MARK: Account
        container.register(ApplyAccountUseCase.self) { r in
            ApplyAccountUseCase(accountRepository: r.resolve(AccountRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FetchMyAccountsUseCase.self) { r in
            FetchMyAccountsUseCase(accountRepository: r.resolve(AccountRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FetchAccountByBankAndAccountUseCase.self) { r in
            FetchAccountByBankAndAccountUseCase(accountRepository: r.resolve(AccountRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FetchAccountsByPhoneUseCase.self) { r in
            FetchAccountsByPhoneUseCase(accountRepository: r.resolve(AccountRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FetchAccountByAccountUseCase.self) { r in
            FetchAccountByAccountUseCase(accountRepository: r.resolve(AccountRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FetchOtherAccountsUseCase.self) { r in
            FetchOtherAccountsUseCase(accountRepository: r.resolve(AccountRepository.self)!)
        }
        
        container.register(ApplyAddAccountsUseCase.self) { r in
            ApplyAddAccountsUseCase(accountRepository: r.resolve(AccountRepository.self)!)
        }
        
        // MARK: Transfer
        container.register(TransferSendUseCase.self) { r in
            TransferSendUseCase(transferRepository: r.resolve(TransferRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(TransferGetUseCase.self) { r in
            TransferGetUseCase(transferRepository: r.resolve(TransferRepository.self)!)
        }
        .inObjectScope(.container)
        
        // MARK: KakaoTransfer
        container.register(KakaoTransferSendUseCase.self) { r in
            KakaoTransferSendUseCase(kakaoTransferRepository: r.resolve(KakaoTransferRepository.self)!)
        }
        .inObjectScope(.container)
        
        // MARK: Upload
        container.register(UploadUseCase.self) { r in
            UploadUseCase(uploadRepository: r.resolve(UploadRepository.self)!)
        }
        .inObjectScope(.container)
    }
}
