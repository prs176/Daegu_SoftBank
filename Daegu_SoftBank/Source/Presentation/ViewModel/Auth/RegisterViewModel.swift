//
//  RegisterViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/06.
//

import Foundation
import UIKit

class RegisterViewModel: ObservableObject {
    @Published var id = ""
    @Published var pw = ""
    @Published var phoneNum = "" {
        didSet {
            if oldValue.count < phoneNum.count, (phoneNum.count == 3 || phoneNum.count == 8) {
                phoneNum = phoneNum + "-"
            }
        }
    }
    @Published var rrn = ""
    @Published var name = ""
    @Published var nickname = ""
    @Published var profileImage: UIImage? = nil
    @Published var isAgree = false
    
    func register() {
        
    }
}
