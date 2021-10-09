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
    
    func resetAuthNumLetters() {
        authNumLetters = ["", "", "", "", "", ""]
        authNumCursor = 0
    }
    
    func login() {
        if !validate() {
            return
        }
        
        isSuccess = true
    }
}

extension LoginViewModel {
    func validate() -> Bool {
        if authNumLetters.contains("") {
            if id.isEmpty {
                isErrorOcuured = true
                errorMessage = "아이디를 입력해주세요."
                return false
            }
            
            if  pw.isEmpty {
                isErrorOcuured = true
                errorMessage = "비밀번호를 입력해주세요."
                return false
            }
        }
        
        return true
    }
}
