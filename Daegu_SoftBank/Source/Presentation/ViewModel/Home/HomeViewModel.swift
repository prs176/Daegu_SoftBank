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
    @Published var accounts = [Account(), Account()]
    
    func refresh() {
        
    }
}
