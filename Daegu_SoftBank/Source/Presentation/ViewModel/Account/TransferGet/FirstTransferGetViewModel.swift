//
//  FirstTransferGetViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/13.
//

import Foundation

class FirstTransferGetViewModel: BaseViewModel {
    @Published var selectedAccount: Account = Account()
    
    var accounts: [Account]
    
    var receiveAccount: Account
    var request: TransferSendRequest = TransferSendRequest()
    
    init(accounts: [Account], receiveAccount: Account) {
        self.accounts = accounts
        self.receiveAccount = receiveAccount
        self.request.receiveAccountId = receiveAccount.account
    }
}
