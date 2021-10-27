//
//  HomeViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import SwiftUI

class HomeViewModel: BaseViewModel {
    @Published var profileImage: UIImage? = nil
    @Published var name: String = ""
    @Published var accounts: [Account] = []
    
    let fetchMyUserUseCase: FetchMyUserUseCase
    
    init(fetchMyUserUseCase: FetchMyUserUseCase) {
        self.fetchMyUserUseCase = fetchMyUserUseCase
        
        super.init()
        
        refresh()
    }
    
    func refresh() {
        addCancellable(publisher: fetchMyUserUseCase.buildUseCasePublisher()) { [weak self] user in
            self?.name = user.name
            self?.accounts = user.account
        }
    }
}
