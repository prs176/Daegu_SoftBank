//
//  Account.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import Foundation

class Account: Codable, Hashable {
    var idx: Int
    var accountNum: String
    var bank: String
    var name: String
    var balance: Int
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.idx == rhs.idx
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(idx)
    }
    
    internal init(idx: Int, accountNum: String, bank: String, name: String, balance: Int) {
        self.idx = idx
        self.accountNum = accountNum
        self.bank = bank
        self.name = name
        self.balance = balance
    }
}
