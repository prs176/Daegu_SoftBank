//
//  SecondTransferViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class SecondTransferViewModel: BaseViewModel {
    var name: String
    var withdrawAccount: Account
    
    var request: TransferRequest
    
    @Published var fees: Int = 0
    
    init(name: String, withdrawAccount: Account, request: TransferRequest) {
        self.name = name
        self.withdrawAccount = withdrawAccount
        self.request = request
        
        super.init()
        
        getFees()
    }
    
    func getFees() {
        self.fees = 300
    }
}
