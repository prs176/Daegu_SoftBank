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
            if oldValue.count < phoneNum.count, (phoneNum.count == 3 || phoneNum.count == 8) {
                phoneNum = phoneNum + "-"
            }
            else if oldValue.count > phoneNum.count, oldValue.last == "-" {
                phoneNum.removeLast()
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
    
    @Published var rnnCursor: Int = 7
    
    @Published var isSuccess: Bool = false
    
    func resetRnnLetters() {
        rrnLetters = ["", "", "", "", "", "", ""]
        rnnCursor = 0
    }
    
    func register() {
        if !validate() {
            return
        }
        
        isSuccess = true
    }
}

extension RegisterViewModel {
    func validate() -> Bool {
        if profileImage == nil {
            isErrorOcuured = true
            errorMessage = "프로필 사진을 선택해주세요."
            return false
        }
        
        if id.isEmpty {
            isErrorOcuured = true
            errorMessage = "아이디를 입력해주세요."
            return false
        }
        
        if pw.isEmpty {
            isErrorOcuured = true
            errorMessage = "비밀번호를 입력해주세요."
            return false
        }
        
        if phoneNum.isEmpty {
            isErrorOcuured = true
            errorMessage = "전화번호를 입력해주세요."
            return false
        }
        
        if rrnLetters.contains("") {
            isErrorOcuured = true
            errorMessage = "주민등록번호를 입력해주세요."
            return false
        }
        
        if name.isEmpty {
            isErrorOcuured = true
            errorMessage = "이름을 입력해주세요."
            return false
        }
        
        if nickname.isEmpty {
            isErrorOcuured = true
            errorMessage = "별명을 선택해주세요."
            return false
        }
        
        if !isAgree {
            isErrorOcuured = true
            errorMessage = "약관에 동의해주세요."
            return false
        }
        
        return true
    }
}
