//
//  MoyaProvider.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Moya
import Alamofire
import Combine

extension MoyaProvider {
    func request(_ target: Target, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Moya.Response, Error> {
        if(!NetworkReachabilityManager(host:Constants.DEFAULT_HOST)!.isReachable) {
            return Future<Moya.Response, Error> { result in
                result(.failure(SoftBankError.error(message: "서버에 접속할 수 없습니다.")))
            }
            .timeout(120, scheduler: DispatchQueue.main, customError: { SoftBankError.error(message: "요청시간이 만료되었습니다.") })
            .eraseToAnyPublisher()
        }
        
        return self.requestPublisher(target, callbackQueue: callbackQueue)
            .mapError { error -> Error in
                let errorBody = (try? error.response?.mapJSON() as? Dictionary<String, Any>) ?? Dictionary()
                
                return SoftBankError.error(message: errorBody["message"] as? String ?? "네트워크 오류가 발생했습니다.", errorBody: ["status":error.response?.statusCode ?? 0])
            }
            .timeout(120, scheduler: DispatchQueue.main, customError: { SoftBankError.error(message: "요청시간이 만료되었습니다.") })
            .eraseToAnyPublisher()
    }
}
