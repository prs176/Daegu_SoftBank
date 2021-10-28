//
//  Account.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class Account: Codable, Hashable {
    var idx: Int
    var account: String
    var name: String
    var money: Int
    var userId: String
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        lhs.idx == rhs.idx
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idx)
    }
    
    internal init(idx: Int = 0, account: String = "", name: String = "", money: Int = 0, userId: String = "") {
        self.idx = idx
        self.account = account
        self.name = name
        self.money = money
        self.userId = userId
    }
}
