//
//  AccountInfo.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class AccountInfo: Codable {
    var account: String
    var limit: Int
    var type: String
    
    internal init(
        account: String = "",
        limit: Int = 0,
        type: String = ""
    ) {
        self.account = account
        self.limit = limit
        self.type = type
    }
}
