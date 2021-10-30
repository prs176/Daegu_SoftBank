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
    var name: String
    var phone: String
    var birth: String
    var profileImage: String
    
    internal init(id: String = "", pw: String = "", nick: String = "", name: String = "", phone: String = "", birth: String = "", profileImage: String = "") {
        self.id = id
        self.pw = pw
        self.nick = nick
        self.name = name
        self.phone = phone
        self.birth = birth
        self.profileImage = profileImage
    }
}
