//
//  SecondTransferViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class SecondTransferViewModel: BaseViewModel {
    @Published var fees: Int = 0
    
    var price: Int
    
    init(price: Int) {
        self.price = price
        
        super.init()
        
        getFees()
    }
    
    func getFees() {
        self.fees = 300
    }
}
