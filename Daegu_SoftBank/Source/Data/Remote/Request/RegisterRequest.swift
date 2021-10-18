//
//  RegisterRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class RegisterRequest: Codable {
    var id: String
    var pw: String
    var nick: String
    var phone: String
    var birth: String
    
    internal init(id: String = "", pw: String = "", nick: String = "", phone: String = "", birth: String = "") {
        self.id = id
        self.pw = pw
        self.nick = nick
        self.phone = phone
        self.birth = birth
    }
}