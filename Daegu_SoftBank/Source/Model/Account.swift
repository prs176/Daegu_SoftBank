//
//  Account.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import Foundation

class Account: Codable, Hashable {
    var idx: Int = 0
    var accountNum: String = ""
    var bank: String = ""
    var name: String = ""
    var balance: Int = 0
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.idx == rhs.idx
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(idx)
    }
}
