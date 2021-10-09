//
//  HomeViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import SwiftUI

class HomeViewModel: BaseViewModel {
    @Published var profileImage: UIImage? = nil
    @Published var name = "User"
    @Published var accounts = [Account(idx: 0, accountNum: "1234-123434", name: "안녕", balance: 1000), Account(idx: 1, accountNum: "4321-412342", name: "안안녕", balance: 9000000)]
    
    func refresh() {
        
    }
}
