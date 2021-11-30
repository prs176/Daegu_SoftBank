//
//  AddAccountsRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import Foundation

class AddAccountsRequest: Codable {
    var account: [String]
    
    internal init(account: [String] = []) {
        self.account = account
    }
}
