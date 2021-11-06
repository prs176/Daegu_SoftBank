//
//  HomeViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import SwiftUI

class HomeViewModel: BaseViewModel {
    @Published var user: User = User()
    
    let fetchMyUserUseCase: FetchMyUserUseCase
    
    init(fetchMyUserUseCase: FetchMyUserUseCase) {
        self.fetchMyUserUseCase = fetchMyUserUseCase
    }
    
    func initVars() {
        refresh()
    }
    
    func refresh() {
        addCancellable(publisher: fetchMyUserUseCase.buildUseCasePublisher()) { [weak self] user in
            self?.user = user
        }
    }
}
