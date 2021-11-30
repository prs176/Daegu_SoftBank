//
//  KakaoTransferRemote.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/30.
//

import Combine

class KakaoTransferRemote: BaseRemote<KakaoTransferAPI> {
    func postTransferSend(_ request: KakaoTransferSendRequest) -> AnyPublisher<String, Error> {
        return self.request(.postTransferSend(request))
            .map(MessageResponse.self, using: decoder)
            .map { $0.message }
            .eraseToAnyPublisher()
    }
}
