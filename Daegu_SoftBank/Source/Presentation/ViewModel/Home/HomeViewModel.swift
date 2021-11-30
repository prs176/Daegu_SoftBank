//
//  HomeViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import SwiftUI

class HomeViewModel: BaseViewModel {
    @Published var user: User = User()
    @Published var accounts: ([Account], [OtherAccount]) = ([], [])
    
    let fetchMyUserUseCase: FetchMyUserUseCase
    let fetchMyAccountsUseCase: FetchMyAccountsUseCase
    
    init(fetchMyUserUseCase: FetchMyUserUseCase,
         fetchMyAccountsUseCase: FetchMyAccountsUseCase) {
        self.fetchMyUserUseCase = fetchMyUserUseCase
        self.fetchMyAccountsUseCase = fetchMyAccountsUseCase
    }
    
    func initVars() {
        refresh()
    }
    
    func refresh() {
        addCancellable(publisher: fetchMyUserUseCase.buildUseCasePublisher()) { [weak self] user in
            self?.user = user
        }
        
        addCancellable(publisher: fetchMyAccountsUseCase.buildUseCasePublisher()) { [weak self] accounts in
            self?.accounts = accounts
        }
    }
}
