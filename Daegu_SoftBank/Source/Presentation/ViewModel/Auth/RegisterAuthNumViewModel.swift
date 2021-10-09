//
//  RegisterAuthNumViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/08.
//

import Foundation

class RegisterAuthNumViewModel: BaseViewModel {
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
    
    func registerAuthNum() {
        if !validate() {
            return
        }
        
        isSuccess = true
    }
}

extension RegisterAuthNumViewModel {
    func validate() -> Bool {
        if authNumLetters.contains("") {
            isErrorOcuured = true
            errorMessage = "인증번호를 입력해주세요."
            return false
        }
        
        return true
    }
}
