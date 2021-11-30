//
//  User.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class User: Codable {
    var id: String
    var nick: String
    var name: String
    var phone: String
    var birth: String
    var profileImage: String
    
    enum UserKeys: String, CodingKey {
        case id
        case nick
        case name
        case phone
        case birth
        case profileImage
        case account
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.nick = try container.decodeIfPresent(String.self, forKey: .nick) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        self.birth = try container.decodeIfPresent(String.self, forKey: .birth) ?? ""
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? ""
    }
    
    internal init(
        id: String = "",
        nick: String = "",
        name: String = "",
        phone: String = "",
        birth: String = "",
        profileImage: String = ""
    ) {
        self.id = id
        self.nick = nick
        self.name = name
        self.phone = phone
        self.birth = birth
        self.profileImage = profileImage
    }
}
