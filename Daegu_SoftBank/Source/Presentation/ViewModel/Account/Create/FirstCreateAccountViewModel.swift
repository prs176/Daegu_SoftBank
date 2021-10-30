//
//  FirstCreateAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

class FirstCreateAccountViewModel: BaseViewModel {
    @Published var name: String = ""
    @Published var rrnLetters: [String] = ["", "", "", "", "", "", ""] {
        didSet {
            if rrnLetters.filter({ $0.count > 1 }).count != 0 {
                rrnLetters = oldValue
            }
            if rnnCursor <= 6, rrnLetters[rnnCursor].count > 0 {
                rnnCursor += 1
            }
        }
    }
    
    var rnnCursor: Int = 7
    
    var request: AccountRequest = AccountRequest()
    
    let fetchMyUserUseCase: FetchMyUserUseCase
    
    @Published var isSuccess: Bool = false
    @Published var isFailure: Bool = false
    var user: User = User()
    
    init(fetchMyUserUseCase: FetchMyUserUseCase) {
        self.fetchMyUserUseCase = fetchMyUserUseCase
        
        super.init()
        
        refresh()
    }
    
    func refresh() {
        addCancellable(publisher: fetchMyUserUseCase.buildUseCasePublisher()) { [weak self] in
            self?.user = $0
        } onError: { [weak self] _ in
            self?.isFailure = true
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
    
    func resetRnnLetters() {
        rrnLetters = ["", "", "", "", "", "", ""]
        rnnCursor = 0
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
