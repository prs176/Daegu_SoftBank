//
//  LoginViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import Combine
import SwiftUI

class LoginViewModel: BaseViewModel {
    @Published var id: String = ""
    @Published var pw: String = ""
    @Published var authNumLetters: [String] = ["", "", "", "", "", ""]
    
    let loginUseCase: LoginUseCase
    let loginByAuthNumUseCase: LoginByAuthNumUseCase
    
    @Published var isSuccess: Bool = false
    
    init(loginUseCase: LoginUseCase,
         loginByAuthNumUseCase: LoginByAuthNumUseCase) {
        self.loginUseCase = loginUseCase
        self.loginByAuthNumUseCase = loginByAuthNumUseCase
    }
    
    func initProps() {
        id = ""
        pw =  ""
        authNumLetters = ["", "", "", "", "", ""]
        isSuccess = false
    }
    
    func update() {
        isSuccess = false
    }
    
    func login() {
        if id.isEmpty, pw.isEmpty {
            addCancellable(publisher: loginByAuthNumUseCase.buildUseCasePublisher(LoginByAuthNumUseCase.Param(pw: authNumLetters.joined()))) { [weak self] in
                self?.isSuccess = true
            }
        }
        else {
            addCancellable(publisher: loginUseCase.buildUseCasePublisher(LoginUseCase.Param(id: id, pw: pw))) { [weak self] in
                self?.isSuccess = true
            }
        }
    }
}

extension LoginViewModel {
    func enterValidate() -> Bool {
        if authNumLetters.contains("") {
            if id.isEmpty {
                return false
            }
            
            if pw.isEmpty {
                return false
            }
        }
        
        return true
    }
}
