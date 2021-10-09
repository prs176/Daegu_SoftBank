//
//  RegisterView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/06.
//

import SwiftUI
import PhotosUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    
    @State var isPresentedWebView = false
    @State var isPresentedPhotoPicker = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ZStack {
                    if let image = viewModel.profileImage {
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
                    isPresentedPhotoPicker.toggle()
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("아이디")
                        if let available = viewModel.isIdAvailable {
                            Text(available ? "사용 가능한 아이디입니다." : "사용 불가능한 아이디입니다.")
                                .font(.caption)
                                .foregroundColor(available ? .secondary : .red)
                        }
                    }
                    HStack {
                        TextField("영문+숫자 조합, 3~12자", text: $viewModel.id)
                            .textFieldStyle(LabelTextFieldStyle())
                            .onChange(of: viewModel.id, perform: { value in
                                viewModel.isIdAvailable = nil
                            })
                        
                        Button(action: {
                            viewModel.idDoubleCheck()
                        }, label: {
                            Text("중복확인")
                        })
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("비밀번호")
                        if let available = viewModel.isPwAvailable {
                            Text(available ? "사용 가능한 비밀번호입니다." : "사용 불가능한 비밀번호입니다.")
                                .font(.caption)
                                .foregroundColor(available ? .secondary : .red)
                        }
                    }
                    HStack {
                        SecureField("영문+숫자+특수문자(!@#$%^*+=-) 조합, 8~12자", text: $viewModel.pw)
                            .textFieldStyle(LabelTextFieldStyle())
                            .onChange(of: viewModel.pw, perform: { value in
                                viewModel.isPwAvailable = nil
                            })
                        
                        Button(action: {
                            viewModel.pwDoubleCheck()
                        }, label: {
                            Text("중복확인")
                        })
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("전화번호")
                    TextField("11자", text: $viewModel.phoneNum, onEditingChanged: { isEditing in
                        if isEditing {
                            viewModel.phoneNum = ""
                        }
                        else {
                            if viewModel.phoneNum.count == 11 {
                                viewModel.phoneNum.insert("-", at: viewModel.phoneNum.index(viewModel.phoneNum.startIndex, offsetBy: 3))
                                viewModel.phoneNum.insert("-", at: viewModel.phoneNum.index(viewModel.phoneNum.startIndex, offsetBy: 8))
                            }
                        }
                    })
                    .textFieldStyle(LabelTextFieldStyle())
                    .keyboardType(.numberPad)
                }
                
                VStack(alignment: .leading) {
                    Text("주민등록번호")
                    HStack {
                        ForEach(0..<6, id: \.self) { idx in
                            AutoFocusTextField(text: $viewModel.rrnLetters[idx], isFirstResponder: viewModel.rnnCursor == idx)
                                .padding(.vertical)
                                .padding(.horizontal, 5)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(5.0)
                                .disabled(viewModel.rnnCursor != idx)
                        }
                    
                        Image(systemName: "minus")
                            .font(.caption)
                        
                        AutoFocusTextField(text: $viewModel.rrnLetters[6], isFirstResponder: viewModel.rnnCursor == 6)
                            .padding(.vertical)
                            .padding(.horizontal, 5)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(5.0)
                            .disabled(viewModel.rnnCursor != 6)
                    }
                    .highPriorityGesture(TapGesture().onEnded {
                        viewModel.resetRnnLetters()
                    })
                }
                
                VStack(alignment: .leading) {
                    Text("이름(실명)")
                    TextField("", text: $viewModel.name)
                        .textFieldStyle(LabelTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("별명")
                        if let available = viewModel.isNicknameAvailable {
                            Text(available ? "사용 가능한 별명입니다." : "사용 불가능한 별명입니다.")
                                .font(.caption)
                                .foregroundColor(available ? .secondary : .red)
                        }
                    }
                    HStack {
                        TextField("2자 이상", text: $viewModel.nickname)
                            .textFieldStyle(LabelTextFieldStyle())
                            .onChange(of: viewModel.nickname, perform: { value in
                                viewModel.isNicknameAvailable = nil
                            })
                        
                        Button(action: {
                            viewModel.nicknameDoubleCheck()
                        }, label: {
                            Text("중복확인")
                        })
                    }
                }
                
                HStack {
                    Button(action: {
                        isPresentedWebView.toggle()
                    }, label: {
                        Text("약관동의")
                    })
                    
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
        .onTapGesture {
            viewModel.rnnCursor = 7
        }
        .sheet(isPresented: $isPresentedPhotoPicker) {
            PhotoPicker(configuration: getConfiguration(), photo: $viewModel.profileImage)
        }
        .sheet(isPresented: $isPresentedWebView) {
            WebView(url: "https://docs.google.com/document/d/1XrCnV4_17cBfQx_Elo6ux33biBjJQc33ebBezdCkc8c/edit")
        }
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.inline)
        .navigate(to: RegisterAuthNumView(), when: $viewModel.isSuccess)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
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
