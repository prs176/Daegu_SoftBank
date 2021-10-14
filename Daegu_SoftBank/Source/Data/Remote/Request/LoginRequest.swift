//
//  LoginRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class LoginRequest: Codable {
    var id: String
    var pw: String
    
    internal init(id: String, pw: String) {
        self.id = id
        self.pw = pw
    }
}
