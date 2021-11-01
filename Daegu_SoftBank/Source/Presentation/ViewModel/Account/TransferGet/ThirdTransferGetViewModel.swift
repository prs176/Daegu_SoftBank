//
//  ThirdTransferGetViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/13.
//

import Foundation

class ThirdTransferGetViewModel: BaseViewModel {
    @Published var pwLetters: [String] = ["", "", "", ""]
    var receiveAccount: Account
    
    var request: TransferSendRequest
    
    let transferSendUseCase: TransferSendUseCase
    
    @Published var isSuccess: Bool = false
    
    init(transferSendUseCase: TransferSendUseCase,
         receiveAccount: Account,
         request: TransferSendRequest) {
        self.transferSendUseCase = transferSendUseCase
        
        self.receiveAccount = receiveAccount
        self.request = request
    }
    
    func apply() {
        guard validate() else {
            return
        }
        
        request.sendAccountPw = pwLetters.joined()
        
        addCancellable(publisher: transferSendUseCase.buildUseCasePublisher(TransferSendUseCase.Param(request: request))) { [weak self] _ in
            self?.isSuccess = true
        }
    }
}

extension ThirdTransferGetViewModel {
    func validate() -> Bool {
        if !pwLetters.joined().isNumber() {
            isErrorOcuured = true
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
