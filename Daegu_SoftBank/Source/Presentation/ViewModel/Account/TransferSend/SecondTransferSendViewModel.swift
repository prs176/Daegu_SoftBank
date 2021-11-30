//
//  SecondTransferSendViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class SecondTransferSendViewModel: BaseViewModel {
    @Published var receiveAccount: Account = Account()
    @Published var request: TransferSendRequest = TransferSendRequest()
    
    var fees: Int = 500
    
    func update(
        receiveAccount: Account,
        request: TransferSendRequest
    ) {
        self.receiveAccount = receiveAccount
        self.request = request
        self.fees = 500
    }
}
