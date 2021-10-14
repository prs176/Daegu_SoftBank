//
//  SoftBankError.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

enum SoftBankError: Error {
    case error(message: String, type: ErrorType = .basic, errorBody: Dictionary<String, Any> = Dictionary())
}

enum ErrorType: String {
    case basic = "BASIC"
    case selfIsNil = "SELF_IS_NIL"
    case unhandled = "UNHANDLED"
}
