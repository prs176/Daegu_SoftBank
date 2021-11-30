//
//  TransferRepositoryImpl.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

class TransferRepositoryImpl: TransferRepository {
    let transferRemote: TransferRemote
    
    init(transferRemote: TransferRemote) {
        self.transferRemote = transferRemote
    }
    
    func transferSend(_ request: TransferSendRequest) -> AnyPublisher<String, Error> {
        transferRemote.postTransferSend(request)
    }
}
