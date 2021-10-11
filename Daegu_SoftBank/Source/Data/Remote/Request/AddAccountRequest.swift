//
//  AddAccountRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class AddAccountRequest: Codable {
    var name: String = ""
    var rrn: Int = 0
    var acountsIdx: [Int] = []
}
