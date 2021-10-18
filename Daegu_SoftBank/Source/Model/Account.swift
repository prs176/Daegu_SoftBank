//
//  Account.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class Account: Codable {
    var idx: Int
    var account: String
    var password: String
    var name: String
    var money: Int
    var userId: String
}
