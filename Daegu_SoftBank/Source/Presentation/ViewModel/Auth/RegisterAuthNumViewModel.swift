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
    @Published var reAuthNumLetters: [String] = ["", "", "", "", "", ""] {
        didSet {
            if reAuthNumLetters.filter({ $0.count > 1 }).count != 0 {
                reAuthNumLetters = oldValue
            }
            if authNumCursor <= 5, reAuthNumLetters[authNumCursor].count > 0 {
                authNumCursor += 1
            }
        }
    }
    
    @Published var curStep: Int = 0
    var authNumCursor: Int = 6
    
    @Published var isSuccess: Bool = false
    
    func registerAuthNum() {
        guard validate() else {
            return
        }
        
        isSuccess = true
    }
    
    func resetAuthNumLetters() {
        if curStep == 0 {
            authNumLetters = ["", "", "", "", "", ""]
        }
        else {
            reAuthNumLetters = ["", "", "", "", "", ""]
        }
        authNumCursor = 0
    }
}

extension RegisterAuthNumViewModel {
    func validate() -> Bool {
        if authNumLetters.map({ $0.isNumber() }).contains(false) ||
           reAuthNumLetters.map({ $0.isNumber() }).contains(false) {
            isErrorOcuured = true
            errorMessage = "간편인증번호는 숫자, 6자로 입력해주세요."
            return false
        }
        
        if authNumLetters != reAuthNumLetters {
            isErrorOcuured = true
            errorMessage = "재입력한 번호가 일치하지 않습니다."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if curStep == 0 {
            if authNumLetters.contains("") {
                return false
            }
            
            return true
        }
        else {
            if reAuthNumLetters.contains("") {
                return false
            }
            
            return true
        }
    }
}
