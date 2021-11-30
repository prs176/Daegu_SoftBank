//
//  KakaoTransferGetUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/30.
//

import Combine

class KakaoTransferGetUseCase: BaseParamUseCase {
    let kakaoTransferRepository: KakaoTransferRepository
    
    init(kakaoTransferRepository: KakaoTransferRepository) {
        self.kakaoTransferRepository = kakaoTransferRepository
    }
    
    func buildUseCasePublisher(_ param: Param) -> AnyPublisher<String, Error> {
        kakaoTransferRepository.transferGet(param.request)
    }
    
    class Param {
        let request: KakaoTransferGetRequest
        
        init(request: KakaoTransferGetRequest) {
            self.request = request
        }
    }
}
