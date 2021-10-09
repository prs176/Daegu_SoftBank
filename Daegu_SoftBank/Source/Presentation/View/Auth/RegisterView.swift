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
                    Text("아이디")
                    HStack {
                        TextField("영문+숫자 조합, 3~12자", text: $viewModel.id)
                            .textFieldStyle(LabelTextFieldStyle())
                        Button(action: {}, label: {
                            Text("중복확인")
                        })
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("비밀번호")
                    HStack {
                        SecureField("영문+숫자+특수문자 조합, 8~12자", text: $viewModel.pw)
                            .textFieldStyle(LabelTextFieldStyle())
                        Button(action: {}, label: {
                            Text("중복확인")
                        })
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("전화번호")
                    TextField("", text: $viewModel.phoneNum)
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
                    Text("별명")
                    HStack {
                        TextField("", text: $viewModel.nickname)
                            .textFieldStyle(LabelTextFieldStyle())
                        Button(action: {}, label: {
                            Text("중복확인")
                        })
                    }
                }
                
                Toggle("약관동의", isOn: $viewModel.isAgree)
                
                Button(action: {
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
            }
            .padding()
        }
        .onTapGesture {
            viewModel.rnnCursor = 7
        }
        .sheet(isPresented: $isPresentedPhotoPicker) {
            PhotoPicker(configuration: getConfiguration(), photo: $viewModel.profileImage)
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
