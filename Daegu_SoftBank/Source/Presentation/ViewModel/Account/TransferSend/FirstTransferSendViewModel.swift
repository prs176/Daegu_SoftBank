//
//  FirstTransferSendViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Combine

class FirstTransferSendViewModel: BaseViewModel {
    @Published var money: String = "0"
    @Published var isAgree: Bool = false
    
    var sendAccount: Account = Account()
    @Published var request: TransferSendRequest = TransferSendRequest()
    
    let fetchAccountByBankAndAccountUseCase: FetchAccountByBankAndAccountUseCase
    let fetchAccountByAccountUseCase: FetchAccountByAccountUseCase
    
    @Published var isSuccess: Bool = false
    @Published var name: String = ""
    
    init(fetchAccountByBankAndAccountUseCase: FetchAccountByBankAndAccountUseCase,
         fetchAccountByAccountUseCase: FetchAccountByAccountUseCase) {
        self.fetchAccountByBankAndAccountUseCase = fetchAccountByBankAndAccountUseCase
        self.fetchAccountByAccountUseCase = fetchAccountByAccountUseCase
    }
    
    func initProps() {
        money = "0"
        request = TransferSendRequest()
    }
    
    func update(sendAccount: Account) {
        self.sendAccount = sendAccount
        self.request.sendAccountId = sendAccount.account
        isSuccess = false
        isAgree = false
    }
    
    func fetch() {
        guard validate() else {
            return
        }
        
        addCancellable(
            publisher: fetchAccountByBankAndAccountUseCase.buildUseCasePublisher(FetchAccountByBankAndAccountUseCase.Param(bank: request.bank, account: request.receiveAccountId))
                .flatMap{ [weak self] accountId -> AnyPublisher<Account, Error> in
                    guard let self = self else {
                        return Future<Account, Error> {
                            $0(.failure(SoftBankError.error(message: "계좌조회에 실패했습니다.")))
                        }
                        .eraseToAnyPublisher()
                    }
                    return self.fetchAccountByAccountUseCase.buildUseCasePublisher(FetchAccountByAccountUseCase.Param(account: accountId))
                }
                .eraseToAnyPublisher()
        ) { [weak self] in
            self?.name = $0.userId
            self?.request.receiveAccountId = $0.account
            self?.isSuccess = true
        }
    }
}

extension FirstTransferSendViewModel {
    func validate() -> Bool {
        if !request.receiveAccountId.components(separatedBy: "-").joined().isNumber() {
            isErrorOccurred = true
            errorMessage = "계좌번호는 숫자로 입력해주세요."
            return false
        }
        
        if request.receiveAccountId == request.sendAccountId {
            isErrorOccurred = true
            errorMessage = "보낼 계좌의 계좌번호와 받을 계좌의 계좌번호가 달라야합니다."
            return false
        }
        
        if sendAccount.money < request.money {
            isErrorOccurred = true
            errorMessage = "이체할 금액이 잔액보다 큽니다."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if Int(money) ?? 0 <= 0 {
            return false
        }
        
        if request.receiveAccountId.isEmpty {
            return false
        }
        
        return true
    }
}
