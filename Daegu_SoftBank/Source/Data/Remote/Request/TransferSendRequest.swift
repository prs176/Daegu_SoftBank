//
//  TransferSendRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class TransferSendRequest: Codable {
    var receiveAccountId: String
    var sendAccountPw: String
    var sendAccountId: String
    var money: Int
    
    internal init(receiveAccountId: String = "", sendAccountPw: String = "", sendAccountId: String = "", money: Int = 0) {
        self.receiveAccountId = receiveAccountId
        self.sendAccountPw = sendAccountPw
        self.sendAccountId = sendAccountId
        self.money = money
    }
}
