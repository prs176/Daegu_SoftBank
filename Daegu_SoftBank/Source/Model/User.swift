//
//  User.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class User: Codable {
    var id: String = ""
    var nick: String = ""
    var name: String = ""
    var phone: String = ""
    var birth: String = ""
    var account: [Account] = []
}
