//
//  TransferRepository.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Combine

protocol TransferRepository {
    func transferSend(_ request: TransferSendRequest) -> AnyPublisher<String, Error>
    
    func transferGet(_ request: TransferGetRequest) -> AnyPublisher<String, Error>
}
