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
    
    init(balance: Int) {
        self.balance = balance
        
        formatter.numberStyle = .decimal
    }
}

extension SecondBringViewModel {
    func enterValidate() -> Bool {
        if Int(price)! <= 0 {
            return false
        }
        
        return true
    }
}
