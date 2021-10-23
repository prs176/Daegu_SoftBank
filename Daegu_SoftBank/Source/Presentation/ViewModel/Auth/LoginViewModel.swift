//
//  LoginViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import Combine

class LoginViewModel: BaseViewModel {
    @Published var id: String = ""
    @Published var pw: String = ""
    @Published var authNumLetters: [String] = ["", "", "", "", "", ""] {
        didSet {
            if authNumLetters.filter({ $0.count > 1 }).count != 0 {
                authNumLetters = oldValue
            }
            if authNumCursor <= 5, authNumLetters[authNumCursor].count > 0 {
                authNumCursor += 1
            }
        }
    }
    
    var authNumCursor: Int = 6
    
    let loginUseCase: LoginUseCase
    let loginByAuthNumUseCase: LoginByAuthNumUseCase
    
    @Published var isSuccess: Bool = false
    
    init(loginUseCase: LoginUseCase,
         loginByAuthNumUseCase: LoginByAuthNumUseCase) {
        self.loginUseCase = loginUseCase
        self.loginByAuthNumUseCase = loginByAuthNumUseCase
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
    
    func resetAuthNumLetters() {
        authNumLetters = ["", "", "", "", "", ""]
        authNumCursor = 0
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
