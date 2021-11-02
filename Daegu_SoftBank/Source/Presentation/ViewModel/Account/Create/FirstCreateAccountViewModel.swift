//
//  FirstCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class FirstCreateAccountViewModel: BaseViewModel {
    @Published var name: String = ""
    @Published var rrnLetters: [String] = ["", "", "", "", "", "", ""]
    
    var request: AccountRequest = AccountRequest()
    
    let fetchMyUserUseCase: FetchMyUserUseCase
    
    @Published var isSuccess: Bool = false
    var user: User = User()
    
    init(fetchMyUserUseCase: FetchMyUserUseCase) {
        self.fetchMyUserUseCase = fetchMyUserUseCase
        
        super.init()
        
        refresh()
    }
    
    func update() {
        self.isSuccess = false
        self.user = User()
    }
    
    func refresh() {
        addCancellable(publisher: fetchMyUserUseCase.buildUseCasePublisher()) { [weak self] in
            self?.user = $0
        }
    }
    
    func fetch() {
        guard validate() else {
            return
        }
        
        guard name == user.name, rrnLetters.joined() == user.birth else {
            isErrorOcuured = true
            errorMessage = "이름, 주민등록번호가 일치하지 않습니다."
            return
        }
        
        request.birth = rrnLetters.joined()
        isSuccess = true
    }
}

extension FirstCreateAccountViewModel {
    func validate() -> Bool {
        if !rrnLetters.joined().isNumber() {
            isErrorOcuured = true
            errorMessage = "주민등록번호는 숫자로 입력해주세요."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if name.isEmpty {
            return false
        }
        
        if rrnLetters.contains("") {
            return false
        }
        
        return true
    }
}
