//
//  BaseParamUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Foundation

protocol BaseParamUseCase {
    associatedtype P
    associatedtype T
    
    func buildUseCasePublisher(_ param: P) -> T
}
