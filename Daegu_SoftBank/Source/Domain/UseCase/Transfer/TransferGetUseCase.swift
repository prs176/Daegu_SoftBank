//
//  TransferGetUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/25.
//

import Combine

class TransferGetUseCase: BaseParamUseCase {
    let transferRepository: TransferRepository
    
    init(transferRepository: TransferRepository) {
        self.transferRepository = transferRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<String, Error> {
        transferRepository.transferGet(param.request)
    }
    
    class Param {
        let request: TransferGetRequest
        
        init(request: TransferGetRequest) {
            self.request = request
        }
        
        init(
            receiveAccountId: String,
            sendAccountPw: String,
            sendAccountId: String,
            money: Int
        ) {
            self.request = TransferGetRequest(
                receiveAccountId: receiveAccountId,
                sendAccountPw: sendAccountPw,
                sendAccountId: sendAccountId,
                money: money
            )
        }
    }
}
