//
//  SecondCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class SecondCreateAccountViewModel: BaseViewModel {
    @Published var accountName: String = ""
    var rrn: String
    var phoneNum: String
    
    var request: CreateAccountRequest
    
    init(phoneNum: String, request: CreateAccountRequest) {
        self.phoneNum = phoneNum
        self.request = request
        
        let temp = String(request.rrn)
        self.rrn = String(temp[temp.startIndex..<temp.index(temp.endIndex, offsetBy: -1)]) + "-" + String(temp.last!)
    }
}

extension SecondCreateAccountViewModel {
    func enterValidate() -> Bool {
        if accountName.isEmpty {
            return false
        }
        
        return true
    }
}
