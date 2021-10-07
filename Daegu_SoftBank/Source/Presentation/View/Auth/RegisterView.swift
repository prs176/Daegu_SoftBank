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
    
    @State var isActivedPhotoPicker = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
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
                    isActivedPhotoPicker.toggle()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                
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
                        TextField("영문+숫자+특수문자 조합, 8~12자", text: $viewModel.pw)
                            .textFieldStyle(LabelTextFieldStyle())
                        Button(action: {}, label: {
                            Text("중복확인")
                        })
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("이메일")
                    TextField("", text: $viewModel.phoneNum)
                        .textFieldStyle(LabelTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("주민등록번호")
                    HStack {
                        TextField("", text: $viewModel.rrn)
                            .textFieldStyle(LabelTextFieldStyle())
                        
                        TextField("", text: $viewModel.rrn)
                            .textFieldStyle(LabelTextFieldStyle())
                        
                        TextField("", text: $viewModel.rrn)
                            .textFieldStyle(LabelTextFieldStyle())
                        
                        TextField("", text: $viewModel.rrn)
                            .textFieldStyle(LabelTextFieldStyle())
                        
                        TextField("", text: $viewModel.rrn)
                            .textFieldStyle(LabelTextFieldStyle())
                        
                        TextField("", text: $viewModel.rrn)
                            .textFieldStyle(LabelTextFieldStyle())
                    
                        Image(systemName: "minus")
                    
                        TextField("", text: $viewModel.rrn)
                            .textFieldStyle(LabelTextFieldStyle())
                    }
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
                    .padding(.bottom)
                
                Button(action: {
                    viewModel.register()
                }, label: {
                    Text("회원가입")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12.0)
                        )
                })
            }
            .padding()
        }
        .navigationTitle("회원가입")
        .sheet(isPresented: $isActivedPhotoPicker, content: {
            PhotoPicker(configuration: getConfiguration(), photo: $viewModel.profileImage)
        })
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
