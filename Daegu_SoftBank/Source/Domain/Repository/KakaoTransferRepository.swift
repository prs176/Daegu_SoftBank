//
//  KakaoTransferRepository.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/30.
//

import Combine

protocol KakaoTransferRepository {
    func transferSend(_ request: KakaoTransferSendRequest) -> AnyPublisher<String, Error>
    
    func transferGet(_ request: KakaoTransferGetRequest) -> AnyPublisher<String, Error>
}

