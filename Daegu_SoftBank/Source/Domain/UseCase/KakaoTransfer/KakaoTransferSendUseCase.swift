//
//  KakaoTransferSendUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/30.
//

import Combine

class KakaoTransferSendUseCase: BaseParamUseCase {
    let kakaoTransferRepository: KakaoTransferRepository
    
    init(kakaoTransferRepository: KakaoTransferRepository) {
        self.kakaoTransferRepository = kakaoTransferRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<String, Error> {
        kakaoTransferRepository.transferSend(param.request)
    }
    
    class Param {
        let request: KakaoTransferSendRequest
        
        init(request: KakaoTransferSendRequest) {
            self.request = request
        }
    }
}
