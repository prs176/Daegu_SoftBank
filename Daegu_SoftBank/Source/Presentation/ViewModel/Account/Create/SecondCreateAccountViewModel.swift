//
//  SecondCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class SecondCreateAccountViewModel: BaseViewModel {
    var phoneNum: String
    
    var request: CreateAccountRequest
    
    init(phoneNum: String, request: CreateAccountRequest) {
        self.phoneNum = phoneNum
        self.request = request
    }
}
