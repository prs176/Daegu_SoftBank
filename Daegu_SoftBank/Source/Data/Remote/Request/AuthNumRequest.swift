//
//  AuthNumRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class AuthNumRequest: Codable {
    var pw: String
    
    internal init(pw: String) {
        self.pw = pw
    }
}
