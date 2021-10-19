//
//  TransferSendUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/19.
//

import Combine

class TransferSendUseCase: BaseParamUseCase {
    let transferRepository: TransferRepository
    
    init(transferRepository: TransferRepository) {
        self.transferRepository = transferRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<String, Error> {
        transferRepository.transferSend(param.request)
    }
    
    class Param {
        let request: TransferSendRequest
        
        init(request: TransferSendRequest) {
            self.request = request
        }
        
        init(receiveAccountId: String, sendAccountPw: String, sendAccountId: String, money: Int) {
            self.request = TransferSendRequest(receiveAccountId: receiveAccountId, sendAccountPw: sendAccountPw, sendAccountId: sendAccountId, money: money)
        }
    }
}
