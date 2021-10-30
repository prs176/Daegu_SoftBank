//
//  SecondAddAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/11.
//

import Foundation

class SecondAddAccountViewModel: BaseViewModel {
    var accounts: [Account]
    @Published var selectedAccounts: [Int] = []
    
    var request: AddAccountsRequest = AddAccountsRequest()
    
    @Published var isSuccess: Bool = false
    
    init(accounts: [Account]) {
        self.accounts = accounts
    }
    
    func apply() {
        isSuccess = true
    }
}

extension SecondAddAccountViewModel {
    func enterValidate() -> Bool {
        if selectedAccounts.isEmpty {
            return false
        }
        
        return true
    }
}
