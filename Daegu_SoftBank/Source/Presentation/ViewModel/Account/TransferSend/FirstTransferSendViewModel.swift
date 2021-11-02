//
//  FirstTransferSendViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class FirstTransferSendViewModel: BaseViewModel {
    @Published var money: String = "0"
    @Published var bank: String = "" // 임시
    @Published var isAgree: Bool = false
    
    var sendAccount: Account = Account()
    @Published var request: TransferSendRequest = TransferSendRequest()
    
    let fetchAccountByAccountUseCase: FetchAccountByAccountUseCase
    
    @Published var isSuccess: Bool = false
    @Published var name: String = ""
    
    init(fetchAccountByAccountUseCase: FetchAccountByAccountUseCase) {
        self.fetchAccountByAccountUseCase = fetchAccountByAccountUseCase
    }
    
    func update(sendAccount: Account) {
        self.sendAccount = sendAccount
        self.request.sendAccountId = sendAccount.account
        self.isAgree = false
        self.name = ""
    }
    
    func fetch() {
        guard validate() else {
            return
        }
        
        addCancellable(publisher: fetchAccountByAccountUseCase.buildUseCasePublisher(FetchAccountByAccountUseCase.Param(account: request.receiveAccountId))) { [weak self] in
            self?.name = $0.userId
            self?.request.receiveAccountId = $0.account
            self?.isSuccess = true
        }
    }
}

extension FirstTransferSendViewModel {
    func validate() -> Bool {
        if !request.receiveAccountId.components(separatedBy: "-").joined().isNumber() {
            isErrorOcuured = true
            errorMessage = "계좌번호는 숫자로 입력해주세요."
            return false
        }
        
        if request.receiveAccountId == request.sendAccountId {
            isErrorOcuured = true
            errorMessage = "보낼 계좌의 계좌번호와 받을 계좌의 계좌번호가 달라야합니다."
            return false
        }
        
        if sendAccount.money < request.money {
            isErrorOcuured = true
            errorMessage = "이체할 금액이 잔액보다 큽니다."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if request.money <= 0 {
            return false
        }
        
        if request.receiveAccountId.isEmpty {
            return false
        }
        
        return true
    }
}
