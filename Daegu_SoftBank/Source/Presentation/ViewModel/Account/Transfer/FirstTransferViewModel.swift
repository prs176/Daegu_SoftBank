//
//  FirstTransferViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class FirstTransferViewModel: BaseViewModel {
    @Published var price: String = ""
    @Published var bank: Int = 0
    @Published var accountNum: String = ""
    @Published var isAgree: Bool = false
    
    var balance: Int
    
    var request: TransferRequest = TransferRequest()
    
    @Published var isSuccess: Bool = false
    @Published var name: String = ""
    
    init(idx: Int, balance: Int) {
        request.withdrawAccountIdx = idx
        self.balance = balance
    }
    
    func search() {
        guard validate() else {
            return
        }
        
        request.accountNum = accountNum
        request.bank = ["부산", "토스", "대구"][bank]
        request.price = Int(price)!
        
        name = "로미"
        isSuccess = true
    }
}

extension FirstTransferViewModel {
    func validate() -> Bool {
        if !price.isNumber() {
            isErrorOcuured = true
            errorMessage = "금액은 숫자로 입력해주세요."
            return false
        }
        
        if !accountNum.filter({ $0 != "-" }).isNumber() {
            isErrorOcuured = true
            errorMessage = "계좌번호는 숫자로 입력해주세요."
            return false
        }
        
        if Int(price)! > balance {
            isErrorOcuured = true
            errorMessage = "입금금액이 잔액보다 큽니다."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if price.isEmpty {
            return false
        }
        
        if accountNum.isEmpty {
            return false
        }
        
        return true
    }
}
