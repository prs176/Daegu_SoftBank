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
    
    @Published var authNumCursor: Int = 6
    @Published var curStep: Int = 0
    
    @Published var isSuccess: Bool = false
    
    func registerAuthNum() {
        if authNumLetters != reAuthNumLetters {
            isErrorOcuured = true
            errorMessage = "재입력한 번호가 일치하지 않습니다."
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
    
    func validate() -> Bool {
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
