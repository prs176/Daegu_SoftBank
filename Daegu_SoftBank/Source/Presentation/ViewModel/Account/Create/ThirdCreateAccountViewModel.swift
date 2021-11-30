//
//  ThirdCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class ThirdCreateAccountViewModel: BaseViewModel {
    @Published var request: AccountRequest = AccountRequest()
    
    let applyAccountUseCase: ApplyAccountUseCase
    
    @Published var isSuccess: Bool = false
    var accountInfo: AccountInfo = AccountInfo()
    
    init(applyAccountUseCase: ApplyAccountUseCase) {
        self.applyAccountUseCase = applyAccountUseCase
    }
    
    func initProps(request: AccountRequest) {
        self.request = request
        self.request.accountPW = ""
    }
    
    func update() {
        self.isSuccess = false
    }
    
    func apply() {
        guard validate() else {
            return
        }
        
        addCancellable(publisher: applyAccountUseCase.buildUseCasePublisher(ApplyAccountUseCase.Param(request: request))) { [weak self] in
            self?.accountInfo = $0
            self?.isSuccess = true
        }
    }
}

extension ThirdCreateAccountViewModel {
    func validate() -> Bool {
        if !request.accountPW.isNumber() {
            isErrorOccurred = true
            errorMessage = "입출금통장 비밀번호는 숫자로 입력해주세요."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if request.accountPW.count != 4 {
            return false
        }
        
        return true
    }
}
