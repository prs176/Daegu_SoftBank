//
//  ViewModelAssembly.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/21.
//

import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RegisterViewModel.self) { r in
            RegisterViewModel(fetchIdCheckUseCase: r.resolve(FetchIdCheckUseCase.self)!,
                              fetchNickCheckUseCase: r.resolve(FetchNickCheckUseCase.self)!)
        }
        
        container.register(RegisterAuthNumViewModel.self) { r in
            RegisterAuthNumViewModel(registerUseCase: r.resolve(RegisterUseCase.self)!,
                                     applyAuthNumUseCase: r.resolve(ApplyAuthNumUseCase.self)!,
                                     loginUseCase: r.resolve(LoginUseCase.self)!)
        }
        
        container.register(LoginViewModel.self) { r in
            LoginViewModel(loginUseCase: r.resolve(LoginUseCase.self)!,
                           loginByAuthNumUseCase: r.resolve(LoginByAuthNumUseCase.self)!)
        }
        
        container.register(HomeViewModel.self) { r in
            HomeViewModel(fetchMyUserUseCase: r.resolve(FetchMyUserUseCase.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FirstCreateAccountViewModel.self) { r in
            FirstCreateAccountViewModel(fetchUserByNameAndBirthUseCase: r.resolve(FetchUserByNameAndBirthUseCase.self)!)
        }
        
        container.register(SecondCreateAccountViewModel.self) { (r, user, request) in
            SecondCreateAccountViewModel(user: user, request: request)
        }
    }
}
