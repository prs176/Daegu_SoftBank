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
        .inObjectScope(.container)
        
        container.register(RegisterAuthNumViewModel.self) { r in
            RegisterAuthNumViewModel(registerUseCase: r.resolve(RegisterUseCase.self)!,
                                     applyAuthNumUseCase: r.resolve(ApplyAuthNumUseCase.self)!)
        }
        .inObjectScope(.container)
    }
}
