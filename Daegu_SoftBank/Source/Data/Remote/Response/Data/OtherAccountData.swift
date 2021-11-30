//
//  OtherAccountData.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/29.
//

import Foundation

class OtherAccountData: Codable, Hashable {
    var accountId: String
    var money: String
    var user: OtherUser
    var userPhone: String
    
    static func == (lhs: OtherAccountData, rhs: OtherAccountData) -> Bool {
        return lhs.accountId == rhs.accountId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(accountId)
    }
    
    internal init(
        accountId: String = "",
        money: String = "",
        user: OtherUser = OtherUser(),
        userPhone: String = ""
    ) {
        self.accountId = accountId
        self.money = money
        self.user = user
        self.userPhone = userPhone
    }
}

class OtherUser: Codable {
    var phone: String
    var id: String
    var name: String
    var birth: String
    
    internal init(
        phone: String = "",
        id: String = "",
        name: String = "",
        birth: String = ""
    ) {
        self.phone = phone
        self.id = id
        self.name = name
        self.birth = birth
    }
}
