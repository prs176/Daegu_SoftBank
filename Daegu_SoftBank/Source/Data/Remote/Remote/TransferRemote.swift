//
//  TransferRemote.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/15.
//

import Combine

class TransferRemote: BaseRemote<TransferAPI> {
    func postTransferSend(_ request: TransferSendRequest) -> AnyPublisher<String, Error> {
        return self.request(.postSend(request))
            .map(MessageResponse.self, using: decoder)
            .map { $0.message }
            .eraseToAnyPublisher()
    }
    
    func postTransferGet(_ request: TransferGetRequest) -> AnyPublisher<String, Error> {
        return self.request(.postGet(request))
            .map(MessageResponse.self, using: decoder)
            .map { $0.message }
            .eraseToAnyPublisher()
    }
}