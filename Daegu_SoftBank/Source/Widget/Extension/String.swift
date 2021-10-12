//
//  String.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import Foundation

extension String {
    func isValidId() -> Bool {
        let idRegEx = "[a-zA-Z0-9]{3,12}"
        
        let idTest = NSPredicate(format:"SELF MATCHES %@", idRegEx)
        return idTest.evaluate(with: self)
    }
    
    func isValidPw() -> Bool {
        let pwRegEx = "(?=.*[!@#$%^*+=-])(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^*+=-]{8,12}"
        
        let pwTest = NSPredicate(format:"SELF MATCHES %@", pwRegEx)
        return pwTest.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let phoneRegEx = "([0-9]{3})-([0-9]{4})-([0-9]{4})"
        
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
    
    func isNumber() -> Bool {
        let numberRegEx = "^[0-9]*$"
        
        let numberTest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return numberTest.evaluate(with: self)
    }
}
