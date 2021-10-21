//
//  BaseUseCase.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/18.
//

import Foundation

protocol BaseUseCase {
    associatedtype T
    
    func buildUseCasePublisher() -> T
}
