//
//  ThirdCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class ThirdCreateAccountViewModel: BaseViewModel {
    @Published var pw = ""
    
    var request: AccountRequest = AccountRequest()
    
    let applyAccountUseCase: ApplyAccountUseCase
    
    @Published var isSuccess: Bool = false
    var accountInfo: AccountInfo = AccountInfo()
    
    init(applyAccountUseCase: ApplyAccountUseCase) {
        self.applyAccountUseCase = applyAccountUseCase
    }
    
    func initProps() {
        pw = ""
    }
    
    func update(request: AccountRequest) {
        self.request = request
        self.isSuccess = false
    }
    
    func apply() {
        guard validate() else {
            return
        }
        
        request.accountPW = pw
        addCancellable(publisher: applyAccountUseCase.buildUseCasePublisher(ApplyAccountUseCase.Param(request: request))) { [weak self] in
            self?.accountInfo = $0
            self?.isSuccess = true
        }
    }
}

extension ThirdCreateAccountViewModel {
    func validate() -> Bool {
        if !pw.isNumber() {
            isErrorOccurred = true
            errorMessage = "입출금통장 비밀번호는 숫자로 입력해주세요."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if pw.count < 4 {
            return false
        }
        
        return true
    }
}
