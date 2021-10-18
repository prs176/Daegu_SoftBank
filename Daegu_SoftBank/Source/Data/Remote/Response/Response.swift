//
//  Response.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/14.
//

import Foundation

class Response<T: Codable>: Codable {
    var status: Int
    var message: String
    var data: T
}

class MessageResponse: Codable {
    var status: Int
    var message: String
}
