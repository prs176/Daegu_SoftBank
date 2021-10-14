//
//  FirstBringViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/13.
//

import Foundation

class FirstBringViewModel: BaseViewModel {
    @Published var isActiveSecondBringView: Bool = false
    @Published var selectedAccount: TempAccount = TempAccount()
    
    var accounts: [TempAccount]
    
    var depositAccount: TempAccount
    var request: BringRequest = BringRequest()
    
    init(accounts: [TempAccount], depositAccount: TempAccount) {
        self.accounts = accounts
        self.depositAccount = depositAccount
    }
}
