//
//  ViewModelAssembly.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/21.
//

import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        // MARK: Auth
        container.register(RegisterViewModel.self) { r in
            RegisterViewModel(
                fetchIdCheckUseCase: r.resolve(FetchIdCheckUseCase.self)!,
                fetchNickCheckUseCase: r.resolve(FetchNickCheckUseCase.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(RegisterAuthNumViewModel.self) { (r, uploadRequest, registerRequest) in
            RegisterAuthNumViewModel(
                uploadUseCase: r.resolve(UploadUseCase.self)!,
                registerUseCase: r.resolve(RegisterUseCase.self)!,
                applyAuthNumUseCase: r.resolve(ApplyAuthNumUseCase.self)!,
                loginUseCase: r.resolve(LoginUseCase.self)!,
                uploadRequest: uploadRequest,
                registerRequest: registerRequest
            )
        }
        .inObjectScope(.container)
        
        container.register(LoginViewModel.self) { r in
            LoginViewModel(
                loginUseCase: r.resolve(LoginUseCase.self)!,
                loginByAuthNumUseCase: r.resolve(LoginByAuthNumUseCase.self)!
            )
        }
        .inObjectScope(.container)
        
        
        // MARK: Home
        container.register(HomeViewModel.self) { r in
            HomeViewModel(fetchMyUserUseCase: r.resolve(FetchMyUserUseCase.self)!)
        }
        .inObjectScope(.container)
        
        
        // MARK: Account
        // create account
        container.register(FirstCreateAccountViewModel.self) { r in
            FirstCreateAccountViewModel(fetchMyUserUseCase: r.resolve(FetchMyUserUseCase.self)!)
        }
        .inObjectScope(.container)
        
        container.register(SecondCreateAccountViewModel.self) { (r, user, request) in
            SecondCreateAccountViewModel(
                user: user,
                request: request
            )
        }
        .inObjectScope(.container)
        
        container.register(ThirdCreateAccountViewModel.self) { (r, request) in
            ThirdCreateAccountViewModel(
                applyAccountUseCase: r.resolve(ApplyAccountUseCase.self)!,
                request: request
            )
        }
        .inObjectScope(.container)
        
        // add account
        container.register(FirstAddAccountViewModel.self) { r in
            FirstAddAccountViewModel(
                fetchMyUserUseCase: r.resolve(FetchMyUserUseCase.self)!,
                fetchOtherAccountsUseCase: r.resolve(FetchOtherAccountsUseCase.self)!,
                fetchAccountByAccountUseCase: r.resolve(FetchAccountByAccountUseCase.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(SecondAddAccountViewModel.self) { (r, accounts) in
            SecondAddAccountViewModel(
                applyAddAccountsUseCase: r.resolve(ApplyAddAccountsUseCase.self)!,
                accounts: accounts
            )
        }
        .inObjectScope(.container)
        
        // transfer send account
        container.register(FirstTransferSendViewModel.self) { (r, sendAccount) in
            FirstTransferSendViewModel(
                fetchAccountByAccountUseCase: r.resolve(FetchAccountByAccountUseCase.self)!,
                sendAccount: sendAccount
            )
        }
        .inObjectScope(.container)
        
        container.register(ThirdTransferSendViewModel.self) { (r, request) in
            ThirdTransferSendViewModel(
                transferSendUseCase: r.resolve(TransferSendUseCase.self)!,
                request: request
            )
        }
        .inObjectScope(.container)
        
        // transfer get account
        container.register(ThirdTransferGetViewModel.self) { (r, receiveAccount, request) in
            ThirdTransferGetViewModel(
                transferSendUseCase: r.resolve(TransferSendUseCase.self)!,
                receiveAccount: receiveAccount,
                request: request
            )
        }
        .inObjectScope(.container)
    }
}
