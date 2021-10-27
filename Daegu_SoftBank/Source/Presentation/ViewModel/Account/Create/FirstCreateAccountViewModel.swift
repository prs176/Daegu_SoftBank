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
    
    let fetchUserByNameAndBirthUseCase: FetchUserByNameAndBirthUseCase
    
    @Published var isSuccess: Bool = false
    var user: User = User()
    
    init(fetchUserByNameAndBirthUseCase: FetchUserByNameAndBirthUseCase) {
        self.fetchUserByNameAndBirthUseCase = fetchUserByNameAndBirthUseCase
    }
    
    func fetch() {
        guard validate() else {
            return
        }
        
        request.name = name
        request.birth = rrnLetters.joined()
        
        addCancellable(publisher: fetchUserByNameAndBirthUseCase.buildUseCasePublisher(FetchUserByNameAndBirthUseCase.Param(name: name, birth: rrnLetters.joined()))) { [weak self] in
            self?.user = $0
            self?.isSuccess = true
        }
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
