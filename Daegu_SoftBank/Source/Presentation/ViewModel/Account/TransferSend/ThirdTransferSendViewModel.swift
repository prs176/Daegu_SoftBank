//
//  ThirdTransferSendViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class ThirdTransferSendViewModel: BaseViewModel {
    @Published var pwLetters: [String] = ["", "", "", ""]
    
    var request: TransferSendRequest
    
    @Published var isSuccess: Bool = false
    
    init(request: TransferSendRequest) {
        self.request = request
    }
    
    func apply() {
        guard validate() else {
            return
        }
        
        request.sendAccountPw = pwLetters.joined()
        isSuccess = true
    }
}

extension ThirdTransferSendViewModel {
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

