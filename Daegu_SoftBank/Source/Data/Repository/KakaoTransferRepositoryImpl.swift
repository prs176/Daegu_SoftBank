//
//  KakaoTransferRepositoryImpl.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/30.
//

import Combine

class KakaoTransferRepositoryImpl: KakaoTransferRepository {
    let kakaoTransferRemote: KakaoTransferRemote
    
    init(kakaoTransferRemote: KakaoTransferRemote) {
        self.kakaoTransferRemote = kakaoTransferRemote
    }
    
    func transferSend(_ request: KakaoTransferSendRequest) -> AnyPublisher<String, Error> {
        kakaoTransferRemote.postTransferSend(request)
    }
    
    func transferGet(_ request: KakaoTransferGetRequest) -> AnyPublisher<String, Error> {
        kakaoTransferRemote.postTransferGet(request)
    }
}
