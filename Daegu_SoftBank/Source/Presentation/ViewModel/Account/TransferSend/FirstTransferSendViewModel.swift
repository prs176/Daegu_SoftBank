//
//  FirstTransferSendViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class FirstTransferSendViewModel: BaseViewModel {
    @Published var price: String = "0"
    @Published var bank: Int = 0
    @Published var accountNum: String = ""
    @Published var isAgree: Bool = false
    var withdrawAccount: TempAccount = TempAccount()
    
    var request: TransferRequest = TransferRequest()
    
    @Published var isSuccess: Bool = false
    @Published var name: String = ""
    
    init(withdrawAccount: TempAccount) {
        self.withdrawAccount = withdrawAccount
        request.withdrawAccountIdx = withdrawAccount.idx
    }
    
    func fetch() {
        guard validate() else {
            return
        }
        
        request.price = Int(price.components(separatedBy: ",").joined())!
        request.bank = ["부산", "토스", "대구"][bank]
        request.accountNum = accountNum
        
        name = "로미"
        isSuccess = true
    }
}

extension FirstTransferSendViewModel {
    func validate() -> Bool {
        if !accountNum.components(separatedBy: "-").joined().isNumber() {
            isErrorOcuured = true
            errorMessage = "계좌번호는 숫자로 입력해주세요."
            return false
        }
        
        if withdrawAccount.balance < Int(price.components(separatedBy: ",").joined())! {
            isErrorOcuured = true
            errorMessage = "이체할 금액이 잔액보다 큽니다."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if Int(price.components(separatedBy: ",").joined())! <= 0 {
            return false
        }
        
        if accountNum.isEmpty {
            return false
        }
        
        return true
    }
}
