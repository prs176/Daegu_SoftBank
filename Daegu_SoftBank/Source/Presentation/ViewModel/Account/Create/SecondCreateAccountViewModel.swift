//
//  SecondCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class SecondCreateAccountViewModel: BaseViewModel {
    @Published var name: String = ""
    var birth: String = ""
    var user: User = User()
    
    var request: AccountRequest = AccountRequest()
    
    func update(user: User, request: AccountRequest) {
        self.user = user
        self.request = request
        
        self.birth = request.birth
        birth.insert("-", at: birth.index(before: birth.endIndex))
    }
}

extension SecondCreateAccountViewModel {
    func enterValidate() -> Bool {
        if name.isEmpty {
            return false
        }
        
        request.name = name
        
        return true
    }
}
