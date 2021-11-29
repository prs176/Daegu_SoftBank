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
    var bank: String
    
    enum AccountKeys: String, CodingKey {
        case idx
        case account
        case name
        case money
        case accountType
        case bank
        case user
        case send
        case receive
        case userId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AccountKeys.self)
        
        self.idx = try container.decodeIfPresent(Int.self, forKey: .idx) ?? 0
        self.account = try container.decodeIfPresent(String.self, forKey: .account) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.money = try container.decodeIfPresent(Int.self, forKey: .money) ?? 0
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId) ?? ""
        self.bank = try container.decodeIfPresent(String.self, forKey: .bank) ?? ""
    }
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        lhs.idx == rhs.idx
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idx)
    }
    
    internal init(
        idx: Int = 0,
        account: String = "",
        name: String = "",
        money: Int = 0,
        userId: String = "",
        bank: String = ""
    ) {
        self.idx = idx
        self.account = account
        self.name = name
        self.money = money
        self.userId = userId
        self.bank = bank
    }
}
