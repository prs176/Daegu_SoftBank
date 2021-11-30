//
//  ThirdTransferSendViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class ThirdTransferSendViewModel: BaseViewModel {
    @Published var pw = ""
    
    var request: TransferSendRequest = TransferSendRequest()
    
    let kakaoTransferSendUseCase: KakaoTransferSendUseCase
    let transferSendUseCase: TransferSendUseCase
    
    @Published var isSuccess: Bool = false
    
    init(
        kakaoTransferSendUseCase: KakaoTransferSendUseCase,
        transferSendUseCase: TransferSendUseCase
    ) {
        self.kakaoTransferSendUseCase = kakaoTransferSendUseCase
        self.transferSendUseCase = transferSendUseCase
    }
    
    func initProps() {
        pw = ""
    }
    
    func update(request: TransferSendRequest) {
        self.request = request
        self.isSuccess = false
    }
    
    func apply() {
        guard validate() else {
            return
        }
        
        request.sendAccountPw = pw
        
        if request.sendAccountId.hasPrefix(BankType.KAKAO.idPrefix) {
            addCancellable(
                publisher: kakaoTransferSendUseCase.buildUseCasePublisher(
                    KakaoTransferSendUseCase.Param(
                        request: KakaoTransferSendRequest(
                            receiveAccountId: request.receiveAccountId,
                            sendAccountPw: request.sendAccountPw,
                            sendAccountId: request.sendAccountId,
                            money: request.money
                        )
                    )
                )
            ) { [weak self] _ in
                self?.isSuccess = true
            }
        }
        else {
            addCancellable(publisher: transferSendUseCase.buildUseCasePublisher(TransferSendUseCase.Param(request: request))) { [weak self] _ in
                self?.isSuccess = true
            }
        }
    }
}

extension ThirdTransferSendViewModel {
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

