//
//  AccountRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class AccountRequest: Codable {
    var accountPW: String
    var name: String
    var birth: String
    
    internal init(
        accountPW: String = "",
        name: String = "",
        birth: String = ""
    ) {
        self.accountPW = accountPW
        self.name = name
        self.birth = birth
    }
}
