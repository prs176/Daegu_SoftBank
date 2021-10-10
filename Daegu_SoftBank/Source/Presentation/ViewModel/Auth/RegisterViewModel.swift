//
//  RegisterViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/06.
//

import Foundation
import UIKit

class RegisterViewModel: BaseViewModel {
    @Published var profileImage: UIImage? = nil
    @Published var id: String = ""
    @Published var pw: String = ""
    @Published var phoneNum: String = "" {
        didSet {
            if phoneNum.filter({ $0 != "-" }).count > 11 {
                phoneNum = oldValue
            }
        }
    }
    @Published var rrnLetters: [String] = ["", "", "", "", "", "", ""] {
        didSet {
            if rrnLetters.filter({ $0.count > 1 }).count != 0 {
                rrnLetters = oldValue
            }
            if rnnCursor <= 6, rrnLetters[rnnCursor].count > 0 {
                rnnCursor += 1
            }
        }
    }
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var isAgree: Bool = false
    
    var rnnCursor: Int = 7
    
    @Published var isIdAvailable: Bool? = nil
    @Published var isPwAvailable: Bool? = nil
    @Published var isNicknameAvailable: Bool? = nil
    @Published var isSuccess: Bool = false
    
    func register() {
        guard validate() else {
            return
        }
        isSuccess = true
    }
    
    func idDoubleCheck() {
        if !id.isValidId() {
            isErrorOcuured = true
            errorMessage = "아이디는 영문+숫자, 3~12자로 입력해주세요."
            return
        }
        
        isIdAvailable = true
    }
    
    func pwDoubleCheck() {
        if !pw.isValidPw() {
            isErrorOcuured = true
            errorMessage = "비밀번호는 영문+숫자+특수문자 조합, 8~12자로 입력해주세요."
            return
        }
        
        isPwAvailable = true
    }
    
    func nicknameDoubleCheck() {
        if nickname.count < 2 {
            isErrorOcuured = true
            errorMessage = "별명은 2자 이상으로 입력해주세요."
            return
        }
        
        isNicknameAvailable = true
    }
    
    func resetRnnLetters() {
        rrnLetters = ["", "", "", "", "", "", ""]
        rnnCursor = 0
    }
}

extension RegisterViewModel {
    func validate() -> Bool {
        if !phoneNum.isValidPhone() {
            isErrorOcuured = true
            errorMessage = "전화번호는 숫자, 11자로 입력해주세요."
            return false
        }
        
        if rrnLetters.map({ $0.isNumber() }).contains(false) {
            isErrorOcuured = true
            errorMessage = "주민등록번호는 숫자, 7자로 입력해주세요."
            return false
        }
        
        if isIdAvailable != true {
            isErrorOcuured = true
            errorMessage = "아이디 중복확인을 진행해주세요."
            return false
        }
        
        if isPwAvailable != true {
            isErrorOcuured = true
            errorMessage = "비밀번호 중복확인을 진행해주세요."
            return false
        }
        
        if isNicknameAvailable != true {
            isErrorOcuured = true
            errorMessage = "별명 중복확인을 진행해주세요."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if profileImage == nil {
            return false
        }
        
        if id.isEmpty {
            return false
        }
        
        if pw.isEmpty {
            return false
        }
        
        if phoneNum.isEmpty {
            return false
        }
        
        if rrnLetters.contains("") {
            return false
        }
        
        if name.isEmpty {
            return false
        }
        
        if nickname.isEmpty {
            return false
        }
        
        if !isAgree {
            return false
        }
        
        return true
    }
}
