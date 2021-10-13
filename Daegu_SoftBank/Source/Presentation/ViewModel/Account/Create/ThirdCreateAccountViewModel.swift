//
//  ThirdCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class ThirdCreateAccountViewModel: BaseViewModel {
    @Published var pwLetters: [String] = ["", "", "", ""] {
        didSet {
            if pwLetters.filter({ $0.count > 1 }).count != 0 {
                pwLetters = oldValue
            }
            if pwCursor <= 3, pwLetters[pwCursor].count > 0 {
                pwCursor += 1
            }
        }
    }
    
    var pwCursor: Int = 4
    
    var request: CreateAccountRequest
    
    @Published var isSuccess: Bool = false
    var accountInfo: AccountInfo = AccountInfo()
    
    init(request: CreateAccountRequest) {
        self.request = request
    }
    
    func apply() {
        guard validate() else {
            return
        }
        
        accountInfo = AccountInfo()
        isSuccess = true
    }
    
    func resetPwLetters() {
        pwLetters = ["", "", "", ""]
        pwCursor = 0
    }
}

extension ThirdCreateAccountViewModel {
    func validate() -> Bool {
        if !pwLetters.joined().isNumber() {
            isErrorOcuured = true
            errorMessage = "입출금통장 비밀번호는 숫자로 입력해주세요."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if pwLetters.contains("") {
            return false
        }
        
        return true
    }
}
