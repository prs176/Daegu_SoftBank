//
//  TransferGetRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/25.
//

import Foundation

class TransferGetRequest: Codable {
    var receiveAccountId: String
    var sendAccountPw: String
    var sendAccountId: String
    var money: Int
    
    internal init(
        receiveAccountId: String = "",
        sendAccountPw: String = "",
        sendAccountId: String = "",
        money: Int = 0
    ) {
        self.receiveAccountId = receiveAccountId
        self.sendAccountPw = sendAccountPw
        self.sendAccountId = sendAccountId
        self.money = money
    }
}
