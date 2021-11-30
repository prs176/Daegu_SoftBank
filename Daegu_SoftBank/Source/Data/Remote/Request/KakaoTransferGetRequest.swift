//
//  KakaoTransferGetRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/30.
//

import Foundation

class KakaoTransferGetRequest: Codable {
    var sendAccountId: String
    var receiveAccountId: String
    var money: Int
    
    internal init(
        sendAccountId: String = "",
        receiveAccountId: String = "",
        money: Int = 0
    ) {
        self.sendAccountId = sendAccountId
        self.receiveAccountId = receiveAccountId
        self.money = money
    }
}
