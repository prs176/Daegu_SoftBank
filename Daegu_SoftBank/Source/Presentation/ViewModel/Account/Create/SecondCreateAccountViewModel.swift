//
//  SecondCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class SecondCreateAccountViewModel: BaseViewModel {
    @Published var accountName: String = ""
    
    var request: CreateAccountRequest
    
    init(request: CreateAccountRequest) {
        self.request = request
    }
}

extension SecondCreateAccountViewModel {
    func enterValidate() -> Bool {
        if accountName.isEmpty {
            return false
        }
        
        request.accountName = accountName
        
        return true
    }
}
