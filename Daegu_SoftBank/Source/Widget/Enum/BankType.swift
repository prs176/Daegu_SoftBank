//
//  BankType.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/02.
//

import Foundation

enum BankType: Int, CaseIterable, Identifiable, CustomStringConvertible {
    case KAKAO = 1
    case TOSS = 2
    case SINHAN = 3
    
    var id: BankType { self }
    
    var description: String {
        switch self {
        case .KAKAO:
            return "KaKao"
        case .TOSS:
            return "Toss"
        case .SINHAN:
            return "Sinhan"
        }
    }
    
    var idPrefix: String {
        switch (self) {
        case .KAKAO:
            return "001"
        case .TOSS:
            return "002"
        case .SINHAN:
            return "003"
        }
    }
}
