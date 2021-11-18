//
//  RegisterView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/06.
//

import SwiftUI
import PhotosUI

struct RegisterView: View {
    @StateObject var viewModel = DependencyProvider.shared.container.resolve(RegisterViewModel.self)!
    
    @State var isWebViewPresented = false
    @State var isPhotoPickerPresented = false
    
    @State var isLoaded: Bool = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    if let image = viewModel.uploadRequest.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    }
                    else {
                        Image(systemName: "camera")
                            .foregroundColor(Color(.tertiaryLabel))
                    }
                }
                .frame(width: 100, height: 100)
                .background(Color(.secondarySystemBackground))
                .clipShape(Circle())
                .onTapGesture {
                    isPhotoPickerPresented.toggle()
                }
                
                VStack {
                    HStack {
                        Text("아이디")
                        
                        if let isValid = viewModel.isIdValid {
                            Text(isValid ? "사용 가능한 아이디입니다." : "사용 불가능한 아이디입니다.")
                                .font(.caption)
                                .foregroundColor(isValid ? .secondary : .red)
                        }
                        
                        Spacer()
                        
                        Button(action: viewModel.checkId) { Text("중복확인") }
                    }
                    
                    TextField("영소문자+숫자, 3~12자", text: $viewModel.registerRequest.id)
                        .textFieldStyle(LabelTextFieldStyle())
                        .autocapitalization(.none)
                        .onChange(of: viewModel.registerRequest.id, perform: { value in
                            viewModel.isIdValid = nil
                        })
                }
                
                VStack(alignment: .leading) {
                    Text("비밀번호")
                    
                    SecureField("영문자+숫자+특수문자(!@#$%^*+=-), 8~12자", text: $viewModel.registerRequest.pw)
                        .textFieldStyle(LabelTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("비밀번호 재입력")
                    
                    SecureField("영문자+숫자+특수문자(!@#$%^*+=-), 8~12자", text: $viewModel.rePw)
                        .textFieldStyle(LabelTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("전화번호")
                    
                    TextField("숫자, 11자", text: $viewModel.registerRequest.phone, onEditingChanged: { isEditing in
                        if isEditing {
                            viewModel.registerRequest.phone = ""
                        }
                        else {
                            if viewModel.registerRequest.phone.count > 11 {
                                viewModel.registerRequest.phone = String(viewModel.registerRequest.phone.prefix(11))
                                viewModel.registerRequest.phone.insert("-", at: viewModel.registerRequest.phone.index(viewModel.registerRequest.phone.startIndex, offsetBy: 3))
                                viewModel.registerRequest.phone.insert("-", at: viewModel.registerRequest.phone.index(viewModel.registerRequest.phone.startIndex, offsetBy: 8))
                            }
                        }
                    })
                    .textFieldStyle(LabelTextFieldStyle())
                    .keyboardType(.numberPad)
                }
                
                VStack(alignment: .leading) {
                    Text("주민등록번호")
                    
                    AutoFocusTextFields(count: 7, text: $viewModel.registerRequest.birth)
                }
                
                VStack(alignment: .leading) {
                    Text("이름(실명)")
                    TextField("", text: $viewModel.registerRequest.name)
                        .textFieldStyle(LabelTextFieldStyle())
                }
                
                VStack(alignment: .center) {
                    HStack {
                        Text("별명")
                        
                        if let isValid = viewModel.isNickValid {
                            Text(isValid ? "사용 가능한 별명입니다." : "사용 불가능한 별명입니다.")
                                .font(.caption)
                                .foregroundColor(isValid ? .secondary : .red)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.checkNick()
                        }, label: {
                            Text("중복확인")
                        })
                        
                    }
                    
                    TextField("2자 이상", text: $viewModel.registerRequest.nick)
                        .textFieldStyle(LabelTextFieldStyle())
                        .onChange(of: viewModel.registerRequest.nick, perform: { value in
                            viewModel.isNickValid = nil
                        })
                }
                
                HStack {
                    Button(action: { isWebViewPresented.toggle() }) { Text("약관동의") }
                    
                    Spacer()
                    
                    Toggle("약관동의", isOn: $viewModel.isAgree)
                        .labelsHidden()
                }
                
                Button(action: {
                    UIApplication.shared.endEditing(true)
                    viewModel.register()
                }, label: {
                    Text("회원가입")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12.0)
                        )
                })
                .disabled(!viewModel.enterValidate())
            }
            .padding()
        }
        .onAppear {
            if isLoaded {
                viewModel.initVars()
                isLoaded = false
            }
            viewModel.reset()
        }
        .sheet(isPresented: $isPhotoPickerPresented) {
            PhotoPicker(
                configuration: getConfiguration(),
                photo: $viewModel.uploadRequest.image,
                name: $viewModel.uploadRequest.name,
                type: $viewModel.uploadRequest.type
            )
        }
        .sheet(isPresented: $isWebViewPresented) {
            WebView(
                url: "https://docs.google.com/document/d/1XrCnV4_17cBfQx_Elo6ux33biBjJQc33ebBezdCkc8c/edit"
            )
        }
        .navigationTitle("회원가입")
        .navigate(
            to:RegisterAuthNumView(uploadRequest: viewModel.uploadRequest, registerRequest: viewModel.registerRequest),
            when: $viewModel.isSuccess
        )
        .activeErrorToastMessage(
            when: $viewModel.isErrorOccurred,
            message: viewModel.errorMessage
        )
        .resignKeyboardOnDragGesture()
    }
    
    func getConfiguration() -> PHPickerConfiguration {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        
        return configuration
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
