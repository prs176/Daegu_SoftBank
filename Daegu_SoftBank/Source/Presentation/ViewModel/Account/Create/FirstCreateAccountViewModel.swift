//
//  FirstCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class FirstCreateAccountViewModel: BaseViewModel {
    @Published var name = ""
    @Published var birth = ""
    
    var request: AccountRequest = AccountRequest()
    
    let fetchMyUserUseCase: FetchMyUserUseCase
    
    @Published var isSuccess: Bool = false
    @Published var isFailure: Bool = false
    var user: User = User()
    
    init(fetchMyUserUseCase: FetchMyUserUseCase) {
        self.fetchMyUserUseCase = fetchMyUserUseCase
    }
    
    func initProps() {
        if user.birth == "" {
            addCancellable(publisher: fetchMyUserUseCase.buildUseCasePublisher()) { [weak self] in
                self?.user = $0
            } onReceiveFailure: { [weak self] _ in
                self?.isFailure = true
            }
        }
        self.name = ""
        self.birth = ""
    }
    
    func update() {
        self.isSuccess = false
    }
    
    func fetch() {
        guard validate() else {
            return
        }
        
        guard name == user.name, birth == user.birth else {
            isErrorOccurred = true
            errorMessage = "이름, 주민등록번호가 일치하지 않습니다."
            return
        }
        
        request.birth = birth
        isSuccess = true
    }
}

extension FirstCreateAccountViewModel {
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
        
        if birth.isEmpty {
            return false
        }
        
        return true
    }
}
