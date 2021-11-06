//
//  TransferSendRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class TransferSendRequest: Codable {
    var bank: Int
    var receiveAccountId: String
    var sendAccountPw: String
    var sendAccountId: String
    var money: Int
    
    internal init(
        bank: Int = 0,
        receiveAccountId: String = "",
        sendAccountPw: String = "",
        sendAccountId: String = "",
        money: Int = 0
    ) {
        self.bank = bank
        self.receiveAccountId = receiveAccountId
        self.sendAccountPw = sendAccountPw
        self.sendAccountId = sendAccountId
        self.money = money
    }
}
