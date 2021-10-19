//
//  TransferGetRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class TransferGetRequest: Codable {
    var receiveAccountId: String
    var sendAccountPw: String
    var sendAccountId: String
    var money: Int
}
