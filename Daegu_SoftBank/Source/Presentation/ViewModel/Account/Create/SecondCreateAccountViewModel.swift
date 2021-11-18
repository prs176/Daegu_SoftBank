//
//  SecondCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class SecondCreateAccountViewModel: BaseViewModel {
    var user: User = User()
    @Published var request: AccountRequest = AccountRequest()
    
    func initProps() {
        request.name = ""
    }
    
    func update(user: User, request: AccountRequest) {
        self.user = user
        self.request = request
    }
}

extension SecondCreateAccountViewModel {
    func enterValidate() -> Bool {
        if request.name.isEmpty {
            return false
        }
        
        return true
    }
}
