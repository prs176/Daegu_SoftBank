//
//  RegisterViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/06.
//

import Foundation
import UIKit

class RegisterViewModel: BaseViewModel {
    @Published var uploadRequest = UploadRequest()
    @Published var registerRequest = RegisterRequest()
    @Published var rePw = ""
    @Published var isAgree = false
    
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
    
    func initVars() {
        uploadRequest = UploadRequest()
        registerRequest = RegisterRequest()
        rePw = ""
        isAgree = false
        
        isIdValid = nil
        isNickValid = nil
    }
    
    func bind() {
        isSuccess = false
    }
    
    func register() {
        guard validate() else {
            return
        }
        
        registerRequest.phone = registerRequest.phone.filter { "-" != $0 }
        isSuccess = true
    }
    
    func checkId() {
        if !registerRequest.id.isValidId() {
            isErrorOccurred = true
            errorMessage = "아이디는 영소문자+숫자, 3~12자로 입력해주세요."
            return
        }
        
        addCancellable(publisher: fetchIdCheckUseCase.buildUseCasePublisher(FetchIdCheckUseCase.Param(id: registerRequest.id))) { [weak self] isValid in
            self?.isIdValid = isValid
        }
    }
    
    func checkNick() {
        if registerRequest.nick.count < 2 {
            isErrorOccurred = true
            errorMessage = "별명은 2자 이상으로 입력해주세요."
            return
        }
        
        addCancellable(publisher: fetchNickCheckUseCase.buildUseCasePublisher(FetchNickCheckUseCase.Param(nick: registerRequest.nick))) { [weak self] isValid in
            self?.isNickValid = isValid
        }
    }
}

extension RegisterViewModel {
    func validate() -> Bool {
        if !registerRequest.pw.isValidPw() {
            isErrorOccurred = true
            errorMessage = "비밀번호는 영문자+숫자+특수문자 조합, 8~12자로 입력해주세요."
            return false
        }
        
        if rePw != registerRequest.pw {
            isErrorOccurred = true
            errorMessage = "재입력한 비밀번호가 일치하지 않습니다."
            return false
        }
        
        if !registerRequest.phone.isValidPhone() {
            isErrorOccurred = true
            errorMessage = "전화번호는 010-[숫자 4자리]-[숫자 4자리]로 입력해주세요."
            return false
        }
        
        if !registerRequest.birth.isNumber() {
            isErrorOccurred = true
            errorMessage = "주민등록번호는 숫자로 입력해주세요."
            return false
        }
        
        if isIdValid != true {
            isErrorOccurred = true
            errorMessage = "아이디 중복확인을 진행해주세요."
            return false
        }
        
        if isNickValid != true {
            isErrorOccurred = true
            errorMessage = "별명 중복확인을 진행해주세요."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if uploadRequest.image == nil {
            return false
        }
        
        if registerRequest.id.isEmpty {
            return false
        }
        
        if registerRequest.pw.isEmpty {
            return false
        }
        
        if registerRequest.phone.isEmpty {
            return false
        }
        
        if registerRequest.birth.count < 7 {
            return false
        }
        
        if registerRequest.name.isEmpty {
            return false
        }
        
        if registerRequest.nick.isEmpty {
            return false
        }
        
        return isAgree
    }
}
