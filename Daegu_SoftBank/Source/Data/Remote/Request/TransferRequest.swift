//
//  TransferRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class TransferRequest: Codable {
    var account: Account = Account()
    var price: String = ""
    var bank: String = ""
    var pw: String = ""
}
