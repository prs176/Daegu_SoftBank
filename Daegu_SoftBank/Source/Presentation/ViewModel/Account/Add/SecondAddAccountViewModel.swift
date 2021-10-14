//
//  SecondAddAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/11.
//

import Foundation

class SecondAddAccountViewModel: BaseViewModel {
    var accounts: [TempAccount]
    @Published var selectedAccounts: [Int] = []
    
    var request: AddAccountRequest
    
    @Published var isSuccess: Bool = false
    
    init(accounts: [TempAccount], request: AddAccountRequest) {
        self.accounts = accounts
        self.request = request
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
