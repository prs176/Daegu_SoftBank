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
    @Published var accounts = [Account(idx: 0, accountNum: "4321-4321", bank: "미로", name: "미로", balance: 321), Account(idx: 1, accountNum: "1234-1234", bank: "로미", name: "로미", balance: 123)]
    
    func refresh() {
        
    }
}
