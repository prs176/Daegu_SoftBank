//
//  ThirdTransferViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class ThirdTransferViewModel: BaseViewModel {
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
    
    var request: TransferRequest
    
    @Published var isSuccess: Bool = false
    
    init(request: TransferRequest) {
        self.request = request
    }
    
    func apply() {
        guard validate() else {
            return
        }
        
        request.pw = pwLetters.joined()
        isSuccess = true
    }
    
    func resetPwLetters() {
        pwLetters = ["", "", "", ""]
        pwCursor = 0
    }
}

extension ThirdTransferViewModel {
    func validate() -> Bool {
        if pwLetters.map({ $0.isNumber() }).contains(false) {
            isErrorOcuured = true
            errorMessage = "입출금통장 비밀번호는 숫자, 4자로 입력해주세요."
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

