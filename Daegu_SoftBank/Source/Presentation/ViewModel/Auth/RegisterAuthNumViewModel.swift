//
//  RegisterAuthNumViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/08.
//

import Foundation

class RegisterAuthNumViewModel: BaseViewModel {
    @Published var authNumLetters: [String] = ["", "", "", "", "", ""] {
        didSet {
            if authNumLetters.filter({ $0.count > 1 }).count != 0 {
                authNumLetters = oldValue
            }
            if authNumCursor <= 5, authNumLetters[authNumCursor].count > 0 {
                authNumCursor += 1
            }
        }
    }
    @Published var reAuthNumLetters: [String] = ["", "", "", "", "", ""] {
        didSet {
            if reAuthNumLetters.filter({ $0.count > 1 }).count != 0 {
                reAuthNumLetters = oldValue
            }
            if authNumCursor <= 5, reAuthNumLetters[authNumCursor].count > 0 {
                authNumCursor += 1
            }
        }
    }
    
    @Published var curStep: Int = 0
    var authNumCursor: Int = 6
    
    var uploadRequest: UploadRequest
    var registerRequest: RegisterRequest
    
    let uploadUseCase: UploadUseCase
    let registerUseCase: RegisterUseCase
    let applyAuthNumUseCase: ApplyAuthNumUseCase
    let loginUseCase: LoginUseCase
    
    @Published var isSuccessUpload: Bool = false
    @Published var isSuccessRegister: Bool = false
    @Published var isSuccessRegisterAuthNum: Bool = false
    @Published var isSuccessLogin: Bool = false
    
    init(uploadUseCase: UploadUseCase,
         registerUseCase: RegisterUseCase,
         applyAuthNumUseCase: ApplyAuthNumUseCase,
         loginUseCase: LoginUseCase,
         uploadRequest: UploadRequest,
         registerRequest: RegisterRequest) {
        self.uploadUseCase = uploadUseCase
        self.registerUseCase = registerUseCase
        self.applyAuthNumUseCase = applyAuthNumUseCase
        self.loginUseCase = loginUseCase
        
        self.uploadRequest = uploadRequest
        self.registerRequest = registerRequest
    }
    
    func uploadImage() {
        guard validate() else {
            return
        }
        
        addCancellable(publisher: uploadUseCase.buildUseCasePublisher(UploadUseCase.Param(request: uploadRequest))) { [weak self] in
            self?.registerRequest.profileImage = $0
            self?.isSuccessUpload = true
        }
    }
    
    func register() {
        addCancellable(publisher: registerUseCase.buildUseCasePublisher(RegisterUseCase.Param(request: registerRequest))) { [weak self] in
            self?.isSuccessRegister = true
        }
    }
    
    func registerAuthNum() {
        addCancellable(publisher: applyAuthNumUseCase.buildUseCasePublisher(ApplyAuthNumUseCase.Param(pw: authNumLetters.joined()))) { [weak self] _ in
            self?.isSuccessRegisterAuthNum = true
        }
    }
    
    func login() {
        addCancellable(publisher: loginUseCase.buildUseCasePublisher(LoginUseCase.Param(id: registerRequest.id, pw: registerRequest.pw))) { [weak self] in
            self?.isSuccessLogin = true
        }
    }
    
    func resetAuthNumLetters() {
        if curStep == 0 {
            authNumLetters = ["", "", "", "", "", ""]
        }
        else {
            reAuthNumLetters = ["", "", "", "", "", ""]
        }
        authNumCursor = 0
    }
}

extension RegisterAuthNumViewModel {
    func validate() -> Bool {
        if !authNumLetters.joined().isNumber() ||
           !reAuthNumLetters.joined().isNumber() {
            isErrorOcuured = true
            errorMessage = "간편인증번호는 숫자로 입력해주세요."
            return false
        }
        
        if authNumLetters != reAuthNumLetters {
            isErrorOcuured = true
            errorMessage = "재입력한 번호가 일치하지 않습니다."
            return false
        }
        
        return true
    }
    
    func enterValidate() -> Bool {
        if curStep == 0 {
            if authNumLetters.contains("") {
                return false
            }
            
            return true
        }
        else {
            if reAuthNumLetters.contains("") {
                return false
            }
            
            return true
        }
    }
}
