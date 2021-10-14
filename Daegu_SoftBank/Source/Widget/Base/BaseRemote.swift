//
//  BaseRemote.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Combine
import Moya

class BaseRemote<T: TargetType> {
    let provider = MoyaProvider<T>(plugins: [NetworkLoggerPlugin()])
    let decoder = JSONDecoder()
    
    func request(_ target: MoyaProvider<T>.Target, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Moya.Response, Error> {
        return provider.request(target, callbackQueue: callbackQueue)
    }
}

