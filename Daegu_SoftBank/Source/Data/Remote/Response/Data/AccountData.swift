//
//  AccountData.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/29.
//

import Foundation

class AccountData: Codable {
    var accounts: [Account]
    var others: [KakaoAccount]
}
