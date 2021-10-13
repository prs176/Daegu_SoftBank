//
//  FirstBringViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/13.
//

import Foundation

class FirstBringViewModel: BaseViewModel {
    @Published var isActiveSecondBringView: Bool = false
    @Published var selectedAccount: Account = Account()
    
    var accounts: [Account]
    
    var depositAccount: Account
    var request: BringRequest = BringRequest()
    
    init(accounts: [Account], depositAccount: Account) {
        self.accounts = accounts
        self.depositAccount = depositAccount
    }
}
