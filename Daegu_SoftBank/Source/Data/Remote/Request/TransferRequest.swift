//
//  TransferRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class TransferRequest: Codable {
    var depositAccountIdx: Int = 0
    var price: Int = 0
    var bank: String = ""
    var accountNum: String = ""
    var pw: String = ""
}
