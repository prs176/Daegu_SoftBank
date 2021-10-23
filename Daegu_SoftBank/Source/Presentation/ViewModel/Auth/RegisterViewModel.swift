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
    @Published var request = RegisterRequest()
    @Published var rePw: String = ""
    @Published var phone: String = "" {
        didSet {
            if phone.filter({ $0 != "-" }).count > 11 {
                phone = oldValue
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
    @Published var isAgree: Bool = false
    
    var rnnCursor: Int = 7
    
    let fetchIdCheckUseCase: FetchIdCheckUseCase
    let fetchNickCheckUseCase: FetchNickCheckUseCase
    
    @Published var isIdValid: Bool? = nil
    @Published var isNickValid: Bool? = nil
    @Published var isSuccess: Bool = false
    
    init(fetchIdCheckUseCase: FetchIdCheckUseCase,
         fetchNickCheckUseCase: FetchNickCheckUseCase) {
        self.fetchIdCheckUseCase = fetchIdCheckUseCase
        self.fetchNickCheckUseCase = fetchNickCheckUseCase
    }
    
    func register() {
        guard validate() else {
            return
        }
        
        request.phone = phone.filter { $0 != "-" }
        request.birth = rrnLetters.joined()
        isSuccess = true
    }
    
    func checkId() {
        if !request.id.isValidId() {
            isErrorOcuured = true
            errorMessage = "아이디는 영소문자+숫자, 3~12자로 입력해주세요."
            return
        }
        
        addCancellable(publisher: fetchIdCheckUseCase.buildUseCasePublisher(FetchIdCheckUseCase.Param(id: request.id))) { [weak self] isValid in
            self?.isIdValid = isValid
        }
    }
    
    func checkNick() {
        if request.nick.count < 2 {
            isErrorOcuured = true
            errorMessage = "별명은 2자 이상으로 입력해주세요."
            return
        }
        
        addCancellable(publisher: fetchNickCheckUseCase.buildUseCasePublisher(FetchNickCheckUseCase.Param(nick: request.nick))) { [weak self] isValid in
            self?.isNickValid = isValid
        }
    }
    
    func resetRnnLetters() {
        rrnLetters = ["", "", "", "", "", "", ""]
        rnnCursor = 0
    }
}

extension RegisterViewModel {
    func validate() -> Bool {
        if !request.pw.isValidPw() {
            isErrorOcuured = true
            errorMessage = "비밀번호는 영문자+숫자+특수문자 조합, 8~12자로 입력해주세요."
            return false
        }
        
        if rePw != request.pw {
            isErrorOcuured = true
            errorMessage = "재입력한 비밀번호가 일치하지 않습니다."
            return false
        }
        
        if !phone.isValidPhone() {
            isErrorOcuured = true
            errorMessage = "전화번호는 010-[숫자 4자리]-[숫자 4자리]로 입력해주세요."
            return false
        }
        
        if !rrnLetters.joined().isNumber() {
            isErrorOcuured = true
            errorMessage = "주민등록번호는 숫자로 입력해주세요."
            return false
        }
        
        if isIdValid != true {
            isErrorOcuured = true
            errorMessage = "아이디 중복확인을 진행해주세요."
            return false
        }
        
        if isNickValid != true {
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
        
        if request.id.isEmpty {
            return false
        }
        
        if request.pw.isEmpty {
            return false
        }
        
        if phone.isEmpty {
            return false
        }
        
        if rrnLetters.contains("") {
            return false
        }
        
        if request.name.isEmpty {
            return false
        }
        
        if request.nick.isEmpty {
            return false
        }
        
        return isAgree
    }
}
