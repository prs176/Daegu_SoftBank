//
//  ThirdTransferGetViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/13.
//

import Foundation

class ThirdTransferGetViewModel: BaseViewModel {
    @Published var pw = ""
    
    var request: TransferSendRequest = TransferSendRequest()
    
    let transferSendUseCase: TransferSendUseCase
    
    @Published var isSuccess: Bool = false
    
    init(transferSendUseCase: TransferSendUseCase) {
        self.transferSendUseCase = transferSendUseCase
    }
    
    func initProps() {
        pw = ""
    }
    
    func update(
        request: TransferSendRequest
    ) {
        self.request = request
        self.isSuccess = false
    }
    
    func apply() {
        guard validate() else {
            return
        }
        
        request.sendAccountPw = pw
        
        addCancellable(publisher: transferSendUseCase.buildUseCasePublisher(TransferSendUseCase.Param(request: request))) { [weak self] _ in
            self?.isSuccess = true
        }
    }
}

extension ThirdTransferGetViewModel {
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
