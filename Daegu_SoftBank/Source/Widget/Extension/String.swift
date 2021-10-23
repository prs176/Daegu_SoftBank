//
//  String.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import Foundation

extension String {
    func isValidId() -> Bool {
        let idRegEx = "(?=.*[0-9])(?=.*[a-z])[a-z0-9]{3,12}"
        
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
    
    func numberToKorean() -> String? {
        guard self.isNumber() else {
            return nil
        }
        
        guard Int(self) ?? 0 > 0 else {
            return "영"
        }
        
        let num = ["", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구"]
        let jari1 = ["", "십", "백", "천"]
        let jari2 = ["", "만", "억", "조", "경"]
        
        var arr = Array(Array(self).map({ num[Int(String($0))!] }).reversed())
        
        for i in 0 ..< arr.count {
            if !arr[i].isEmpty {
                arr[i] += jari1[i % 4]
            }
            
            if i % 4 == 0 {
                arr[i] += jari2[i / 4]
            }
        }
        
        var removeJari2Arr: [[String]] = []
        
        for i in 0 ..< arr.count / 4 {
            removeJari2Arr.append(Array(arr[i * 4 ..< (i + 1) * 4]))
        }
        
        if arr.count % 4 > 0 {
            removeJari2Arr.append(Array(arr[arr.count / 4 * 4 ..< arr.count]))
        }
        
        for i in 0 ..< removeJari2Arr.count {
            if removeJari2Arr[i].filter({ !jari2.contains($0) && !$0.isEmpty }).count < 1,
               !removeJari2Arr[i][0].isEmpty {
                removeJari2Arr[i][0].removeLast()
            }
        }
        
        return removeJari2Arr.joined().reversed().joined()
    }
}
