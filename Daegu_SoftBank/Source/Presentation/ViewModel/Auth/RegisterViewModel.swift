//
//  RegisterViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/06.
//

import Foundation
import UIKit

class RegisterViewModel: ObservableObject {
    @Published var profileImage: UIImage? = nil
    @Published var id: String = ""
    @Published var pw: String = ""
    @Published var phoneNum: String = "" {
        didSet {
            if oldValue.count < phoneNum.count, (phoneNum.count == 3 || phoneNum.count == 8) {
                phoneNum = phoneNum + "-"
            }
            else if oldValue.count > phoneNum.count, oldValue.last == "-" {
                phoneNum.removeLast()
            }
        }
    }
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
    @Published var rnnCursor: Int = 7
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var isAgree: Bool = false
    
    @Published var isSuccess: Bool = false
    
    func resetRnnLetters() {
        rrnLetters = ["", "", "", "", "", "", ""]
        rnnCursor = 0
    }
    
    func register() {
        isSuccess = true
    }
}
