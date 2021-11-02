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
        
        container.register(RegisterAuthNumViewModel.self) { r in
            RegisterAuthNumViewModel(
                uploadUseCase: r.resolve(UploadUseCase.self)!,
                registerUseCase: r.resolve(RegisterUseCase.self)!,
                applyAuthNumUseCase: r.resolve(ApplyAuthNumUseCase.self)!,
                loginUseCase: r.resolve(LoginUseCase.self)!
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
        
        container.register(SecondCreateAccountViewModel.self) { r in
            SecondCreateAccountViewModel()
        }
        .inObjectScope(.container)
        
        container.register(ThirdCreateAccountViewModel.self) { r in
            ThirdCreateAccountViewModel(applyAccountUseCase: r.resolve(ApplyAccountUseCase.self)!)
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
        
        container.register(SecondAddAccountViewModel.self) { r in
            SecondAddAccountViewModel(applyAddAccountsUseCase: r.resolve(ApplyAddAccountsUseCase.self)!)
        }
        .inObjectScope(.container)
        
        // transfer send account
        container.register(FirstTransferSendViewModel.self) { r in
            FirstTransferSendViewModel(fetchAccountByAccountUseCase: r.resolve(FetchAccountByAccountUseCase.self)!)
        }
        .inObjectScope(.container)
        
        container.register(SecondTransferSendViewModel.self) { r in
            SecondTransferSendViewModel()
        }
        .inObjectScope(.container)
        
        container.register(ThirdTransferSendViewModel.self) { r in
            ThirdTransferSendViewModel(transferSendUseCase: r.resolve(TransferSendUseCase.self)!)
        }
        .inObjectScope(.container)
        
        // transfer get account
        container.register(SecondTransferGetViewModel.self) { r in
            SecondTransferGetViewModel()
        }
        .inObjectScope(.container)
        
        container.register(ThirdTransferGetViewModel.self) { r in
            ThirdTransferGetViewModel(transferSendUseCase: r.resolve(TransferSendUseCase.self)!)
        }
        .inObjectScope(.container)
    }
}
