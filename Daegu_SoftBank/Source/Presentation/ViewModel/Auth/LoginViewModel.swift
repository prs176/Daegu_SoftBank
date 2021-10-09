//
//  LoginViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import Foundation

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
    @Published var authNumCursor: Int = 6
    
    @Published var isSuccess: Bool = false
    
    func login() {
        isSuccess = true
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
            
            if  pw.isEmpty {
                return false
            }
        }
        
        return true
    }
}
