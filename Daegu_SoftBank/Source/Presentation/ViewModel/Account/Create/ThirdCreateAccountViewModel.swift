//
//  ThirdCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class ThirdCreateAccountViewModel: BaseViewModel {
    @Published var pwLetters: [String] = ["", "", "", ""]
    
    var request: AccountRequest = AccountRequest()
    
    let applyAccountUseCase: ApplyAccountUseCase
    
    @Published var isSuccess: Bool = false
    var accountInfo: AccountInfo = AccountInfo()
    
    init(applyAccountUseCase: ApplyAccountUseCase) {
        self.applyAccountUseCase = applyAccountUseCase
    }
    
    func initProps() {
        pwLetters = ["", "", "", ""]
    }
    
    func update(request: AccountRequest) {
        self.request = request
        self.isSuccess = false
    }
    
    func apply() {
        guard validate() else {
            return
        }
        
        request.accountPW = pwLetters.joined()
        addCancellable(publisher: applyAccountUseCase.buildUseCasePublisher(ApplyAccountUseCase.Param(request: request))) { [weak self] _ in
            self?.accountInfo = AccountInfo() // 임시
            self?.isSuccess = true
        }
    }
}

extension ThirdCreateAccountViewModel {
    func validate() -> Bool {
        if !pwLetters.joined().isNumber() {
            isErrorOccurred = true
            errorMessage = "입출금통장 비밀번호는 숫자로 입력해주세요."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if pwLetters.contains("") {
            return false
        }
        
        return true
    }
}
