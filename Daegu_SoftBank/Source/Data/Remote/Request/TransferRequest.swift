//
//  TransferRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class TransferRequest: Codable {
    var withdrawAccountIdx: Int = 0
    var price: Int = 0
    var bank: String = ""
    var accountNum: String = ""
    var pw: Int = 0
}
