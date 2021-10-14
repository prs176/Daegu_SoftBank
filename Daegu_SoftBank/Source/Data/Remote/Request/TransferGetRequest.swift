//
//  TransferGetRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class TransferGetRequest: Codable {
    var withdrawAccountIdx: Int = 0
    var price: Int = 0
    var bank: String = ""
    var accountNum: String = ""
    var pw: Int = 0
    
    internal init(withdrawAccountIdx: Int = 0, price: Int = 0, bank: String = "", accountNum: String = "", pw: Int = 0) {
        self.withdrawAccountIdx = withdrawAccountIdx
        self.price = price
        self.bank = bank
        self.accountNum = accountNum
        self.pw = pw
    }
}
