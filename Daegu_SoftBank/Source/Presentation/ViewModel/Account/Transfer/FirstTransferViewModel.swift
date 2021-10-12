//
//  FirstTransferViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class FirstTransferViewModel: BaseViewModel {
    @Published var price: String = ""
    @Published var bank: Int = 0
    @Published var accountNum: String = ""
    
    var request: TransferRequest = TransferRequest()
    
    @Published var isSuccess: Bool = false
    @Published var name: String = ""
    
    init(account: Account) {
        request.account = account
    }
    
    func search() {
        guard validate() else {
            return
        }
        
        name = "로미"
        isSuccess = true
    }
}

extension FirstTransferViewModel {
    func validate() -> Bool {
        if !price.isNumber() {
            print(price.isNumber())
            isErrorOcuured = true
            errorMessage = "금액은 숫자로 입력해주세요."
            return false
        }
        
        if !accountNum.filter({ $0 != "-" }).isNumber() {
            isErrorOcuured = true
            errorMessage = "계좌번호는 숫자로 입력해주세요."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if price.isEmpty {
            return false
        }
        
        if accountNum.isEmpty {
            return false
        }
        
        return true
    }
}
