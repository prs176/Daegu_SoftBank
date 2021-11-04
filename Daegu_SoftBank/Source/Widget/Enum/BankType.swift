//
//  BankType.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/02.
//

import Foundation

enum BankType: Int, CaseIterable, Identifiable, CustomStringConvertible {
    case KAKAO = 0
    case TOSS = 1
    case SINHAN = 2
    
    var id: BankType { self }
    
    var description: String {
        switch self {
        case .KAKAO:
            return "카카오"
        case .TOSS:
            return "토스"
        case .SINHAN:
            return "신한"
        }
    }
}
