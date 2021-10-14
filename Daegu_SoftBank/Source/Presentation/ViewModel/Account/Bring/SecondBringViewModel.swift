//
//  SecondBringViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class SecondBringViewModel: BaseViewModel {
    @Published var price: String = "0"
    var depositAccount: TempAccount
    var withdrawAccount: TempAccount
    
    var request: BringRequest
    
    @Published var isSuccess: Bool = false
    
    init(depositAccount: TempAccount, withdrawAccount: TempAccount, request: BringRequest) {
        self.depositAccount = depositAccount
        self.withdrawAccount = withdrawAccount
        self.request = request
    }
}

extension SecondBringViewModel {
    func validate() {
        let price = Int(price.components(separatedBy: ",").joined())!
        
        if withdrawAccount.balance < price {
            isErrorOcuured = true
            errorMessage = "가져오기할 금액이 출금가능금액보다 큽니다."
            return
        }
        
        request.price = price
        
        isSuccess = true
    }
    
    func enterValidate() -> Bool {
        if Int(price.components(separatedBy: ",").joined())! <= 0 {
            return false
        }
        
        return true
    }
}
