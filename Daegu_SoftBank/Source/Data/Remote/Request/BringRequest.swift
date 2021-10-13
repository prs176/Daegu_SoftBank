//
//  BringRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class BringRequest: Codable {
    var depositAccountIdx: Int = 0
    var withdrawAccountIdx: Int = 0
    var price: Int = 0
    var pw: Int = 0
}
