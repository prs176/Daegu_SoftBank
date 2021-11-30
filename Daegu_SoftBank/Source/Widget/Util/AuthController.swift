//
//  AuthController.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Foundation

class AuthController {
    let preferences = UserDefaults.standard
    
    func getToken() -> String {
        return preferences.value(forKey: "token") as? String ?? ""
    }
    
    func getSimpleId() -> String {
        return preferences.value(forKey: "simpleId") as? String ?? ""
    }
    
    func refreshToken(token: String) {
        preferences.set(nil, forKey: "token")
        preferences.set(token, forKey: "token")
    }
    
    func login(token: String, simpleId: String) {
        preferences.set(token, forKey: "token")
        preferences.set(simpleId, forKey: "simpleId")
    }
    
    func logout() {
        preferences.set(nil, forKey: "token")
        preferences.set(nil, forKey: "simpleId")
    }
}

extension AuthController {
    private static var authController: AuthController!
    
    static func getInstance() -> AuthController {
        if authController == nil {
            AuthController.authController = AuthController()
        }
        
        return .authController
    }
}
