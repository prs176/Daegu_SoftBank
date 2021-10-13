//
//  SecondBringViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class SecondBringViewModel: BaseViewModel {
    @Published var price: String = "0" {
        didSet {
            let filtered = Int(price.filter { "0123456789".contains($0) }) ?? 0
            
            if String(filtered) != price {
                price = String(filtered)
            }
        }
    }
    
    var formatter: NumberFormatter = NumberFormatter()
    var balance: Int
    
    var request: BringRequest
    
    @Published var isSuccess: Bool = false
    
    init(balance: Int, request: BringRequest) {
        self.balance = balance
        formatter.numberStyle = .decimal
        self.request = request
    }
}

extension SecondBringViewModel {
    func validate() {
        if balance < Int(price)! {
            isErrorOcuured = true
            errorMessage = "가져오기할 금액이 출금가능금액보다 큽니다."
            return
        }
        
        isSuccess = true
    }
    
    func enterValidate() -> Bool {
        if Int(price)! <= 0 {
            return false
        }
        
        request.price = Int(price)!
        
        return true
    }
}
