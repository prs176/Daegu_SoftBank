//
//  SecondAddAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/11.
//

import Foundation

class SecondAddAccountViewModel: BaseViewModel {
    var accounts: [Account] = []
    @Published var selectedAccounts: [String] = []
    
    var request: AddAccountsRequest = AddAccountsRequest()
    
    let applyAddAccountsUseCase: ApplyAddAccountsUseCase
    
    @Published var isSuccess: Bool = false
    
    init(applyAddAccountsUseCase: ApplyAddAccountsUseCase) {
        self.applyAddAccountsUseCase = applyAddAccountsUseCase
    }
    
    func update(accounts: [Account]) {
        self.accounts = accounts
    }
    
    func apply() {
        addCancellable(publisher: applyAddAccountsUseCase.buildUseCasePublisher(ApplyAddAccountsUseCase.Param(accounts: selectedAccounts))) { [weak self] _ in
            self?.isSuccess = true
        }
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
