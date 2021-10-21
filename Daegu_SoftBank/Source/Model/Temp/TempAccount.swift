//
//  TempAccount.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import Foundation

class TempAccount: Codable, Hashable {
    var idx: Int = 0
    var accountNum: String = ""
    var bank: String = ""
    var name: String = ""
    var balance: Int = 0
    
    static func == (lhs: TempAccount, rhs: TempAccount) -> Bool {
        return lhs.idx == rhs.idx
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(idx)
    }
    
    internal init(idx: Int = 0, accountNum: String = "", bank: String = "", name: String = "", balance: Int = 0) {
        self.idx = idx
        self.accountNum = accountNum
        self.bank = bank
        self.name = name
        self.balance = balance
    }
    
    init() {
        idx = 0
        accountNum = ""
        bank = ""
        name = ""
        balance = 0
    }
}
