//
//  SecondTransferGetViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class SecondTransferGetViewModel: BaseViewModel {
    @Published var money: String = "0"
    var receiveAccount: Account = Account()
    var sendAccount: Account = Account()
    
    var request: TransferSendRequest = TransferSendRequest()
    
    @Published var isSuccess: Bool = false
    
    func initProps() {
        money = "0"
    }
    
    func update(
        receiveAccount: Account,
        sendAccount: Account,
        request: TransferSendRequest
    ) {
        self.receiveAccount = receiveAccount
        self.sendAccount = sendAccount
        self.request = request
        
        self.isSuccess = false
    }
}

extension SecondTransferGetViewModel {
    func validate() {
        if sendAccount.money < Int(money.components(separatedBy: ",").joined())! {
            isErrorOcuured = true
            errorMessage = "가져오기할 금액이 출금가능금액보다 큽니다."
            return
        }
        
        isSuccess = true
    }
    
    func enterValidate() -> Bool {
        if Int(money.components(separatedBy: ",").joined()) ?? 0 <= 0 {
            return false
        }
        
        return true
    }
}
