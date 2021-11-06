//
//  LoginViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import Combine
import SwiftUI

class LoginViewModel: BaseViewModel {
    @Published var id = ""
    @Published var pw = ""
    @Published var authNum = ""
    
    let loginUseCase: LoginUseCase
    let loginByAuthNumUseCase: LoginByAuthNumUseCase
    
    @Published var isSuccess: Bool = false
    
    init(loginUseCase: LoginUseCase,
         loginByAuthNumUseCase: LoginByAuthNumUseCase) {
        self.loginUseCase = loginUseCase
        self.loginByAuthNumUseCase = loginByAuthNumUseCase
    }
    
    func bind() {
        id = ""
        pw =  ""
        authNum = ""
        isSuccess = false
    }
    
    func login() {
        if id.isEmpty, pw.isEmpty {
            addCancellable(publisher: loginByAuthNumUseCase.buildUseCasePublisher(LoginByAuthNumUseCase.Param(pw: authNum))) { [weak self] in
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
        if authNum.isEmpty {
            if id.isEmpty {
                return false
            }
            
            if pw.count < 6 {
                return false
            }
        }
        
        return true
    }
}
