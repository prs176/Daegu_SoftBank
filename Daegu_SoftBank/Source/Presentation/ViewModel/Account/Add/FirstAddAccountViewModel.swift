//
//  FirstAddAccountViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import Foundation

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
    
    var request: AddAccountRequest = AddAccountRequest()
    
    @Published var isSuccess: Bool = false
    var accounts: [Account] = []
    
    func fetch() {
        guard validate() else {
            return
        }
        
        request.name = name
        request.rrn = Int(rrnLetters.joined())!
        
        accounts = [Account(idx: 0, accountNum: "321-432", bank: "ㄴㅁㄹ", name: "ㅁㅇㄴㄹ", balance: 123043), Account(idx: 1, accountNum: "3-2123", bank: "fasdf", name: "fasdf", balance: 3142)]
        isSuccess = true
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
            errorMessage = "주민등록번호는 숫자, 7자로 입력해주세요."
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
