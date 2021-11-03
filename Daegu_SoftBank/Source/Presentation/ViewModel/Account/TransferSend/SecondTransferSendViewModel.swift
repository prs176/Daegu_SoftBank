//
//  SecondTransferSendViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation

class SecondTransferSendViewModel: BaseViewModel {
    @Published var name: String = ""
    @Published var request: TransferSendRequest = TransferSendRequest()
    
    var fees: Int = 500
    
    func update(
        name: String,
        request: TransferSendRequest
    ) {
        self.name = name
        self.request = request
        self.fees = 500
    }
}
