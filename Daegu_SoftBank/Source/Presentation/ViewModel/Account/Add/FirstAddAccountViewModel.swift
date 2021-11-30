//
//  FirstAddAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Combine

class FirstAddAccountViewModel: BaseViewModel {
    @Published var name = ""
    @Published var birth = ""
    
    let fetchMyUserUseCase: FetchMyUserUseCase
    let fetchMyAccountsUseCase: FetchMyAccountsUseCase
    let fetchOtherAccountsUseCase: FetchOtherAccountsUseCase
    
    @Published var isSuccess: Bool = false
    @Published var isFailure: Bool = false
    var user: User = User()
    var accounts: [KakaoAccount] = []
    
    init(fetchMyUserUseCase: FetchMyUserUseCase,
         fetchMyAccountsUseCase: FetchMyAccountsUseCase,
         fetchOtherAccountsUseCase: FetchOtherAccountsUseCase) {
        self.fetchMyUserUseCase = fetchMyUserUseCase
        self.fetchMyAccountsUseCase = fetchMyAccountsUseCase
        self.fetchOtherAccountsUseCase = fetchOtherAccountsUseCase
    }
    
    func initProps() {
        if user.birth == "" {
            addCancellable(publisher: fetchMyUserUseCase.buildUseCasePublisher()) { [weak self] in
                self?.user = $0
            } onReceiveFailure: { [weak self] _ in
                self?.isFailure = true
            }
        }
        name = ""
        birth = ""
    }
    
    func update() {
        self.isSuccess = false
        self.isFailure = false
    }
    
    func fetch() {
        guard name == user.name, birth == user.birth else {
            isErrorOccurred = true
            errorMessage = "이름, 주민등록번호가 일치하지 않습니다."
            return
        }
        
        addCancellable(
            publisher: fetchOtherAccountsUseCase.buildUseCasePublisher(FetchOtherAccountsUseCase.Param(birth: birth, name: name))
                .zip(
                    fetchMyAccountsUseCase.buildUseCasePublisher()
                )
                .eraseToAnyPublisher()
        ) { [weak self] otherAccounts, myAccounts in
            let myAccountsId = myAccounts.map({ $0.account })
            
            self?.accounts = otherAccounts.filter({ !myAccountsId.contains($0.accountId) })
            self?.isSuccess = true
        }
    }
}

extension FirstAddAccountViewModel {
    func validate() -> Bool {
        if !birth.isNumber() {
            isErrorOccurred = true
            errorMessage = "주민등록번호는 숫자로 입력해주세요."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if name.isEmpty {
            return false
        }
        
        if birth.count < 7 {
            return false
        }
        
        return true
    }
}
