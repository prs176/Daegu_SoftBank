//
//  FirstAddAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Combine

class FirstAddAccountViewModel: BaseViewModel {
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
    
    let fetchMyUserUseCase: FetchMyUserUseCase
    let fetchOtherAccountsUseCase: FetchOtherAccountsUseCase
    let fetchAccountByAccountUseCase: FetchAccountByAccountUseCase
    
    @Published var isSuccess: Bool = false
    @Published var isFailure: Bool = false
    var user: User = User()
    var accounts: [Account] = []
    
    init(fetchMyUserUseCase: FetchMyUserUseCase,
         fetchOtherAccountsUseCase: FetchOtherAccountsUseCase,
         fetchAccountByAccountUseCase: FetchAccountByAccountUseCase) {
        self.fetchMyUserUseCase = fetchMyUserUseCase
        self.fetchOtherAccountsUseCase = fetchOtherAccountsUseCase
        self.fetchAccountByAccountUseCase = fetchAccountByAccountUseCase
        
        super.init()
        
        refresh()
    }
    
    func refresh() {
        guard validate() else {
            return
        }
        
        addCancellable(publisher: fetchMyUserUseCase.buildUseCasePublisher()) { [weak self] in
            self?.user = $0
        } onError: { [weak self] _ in
            self?.isFailure = true
        }
    }
    
    func fetch() {
        guard name == user.name, rrnLetters.joined() == user.birth else {
            isErrorOcuured = true
            errorMessage = "이름, 주민등록번호가 일치하지 않습니다."
            return
        }
        
        addCancellable(
            publisher: fetchOtherAccountsUseCase.buildUseCasePublisher(FetchOtherAccountsUseCase.Param(birth: rrnLetters.joined(), name: name))
                .flatMap { [weak self] accounts -> AnyPublisher<[Account], Error> in
                    guard let self = self else {
                        return Future<[Account], Error> {
                            $0(.failure(SoftBankError.error(message: "계좌 조회에 실패했습니다.")))
                        }
                        .eraseToAnyPublisher()
                    }
                    
                    return Publishers.MergeMany(accounts.map {
                        self.fetchAccountByAccountUseCase.buildUseCasePublisher(FetchAccountByAccountUseCase.Param(account: $0))
                    })
                    .collect(accounts.count)
                    .eraseToAnyPublisher()
                }.eraseToAnyPublisher()) { [weak self] in
                    self?.accounts = $0
                    self?.isSuccess = true
                }
    }
    
    func resetRnnLetters() {
        rrnLetters = ["", "", "", "", "", "", ""]
        rnnCursor = 0
    }
}

extension FirstAddAccountViewModel {
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
