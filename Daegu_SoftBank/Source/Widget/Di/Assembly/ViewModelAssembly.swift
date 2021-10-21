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
            RegisterViewModel(registerUseCase: r.resolve(RegisterUseCase.self)!)
        }
        
        container.register(RegisterAuthNumViewModel.self) { r in
            RegisterAuthNumViewModel(applyAuthNumUseCase: r.resolve(ApplyAuthNumUseCase.self)!)
        }
    }
}
