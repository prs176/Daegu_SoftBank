//
//  LoginView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = DependencyProvider.shared.container.resolve(LoginViewModel.self)!
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading) {
                Text("아이디")
                TextField("", text: $viewModel.id)
                    .autocapitalization(.none)
                    .textFieldStyle(LabelTextFieldStyle())
            }
            
            VStack(alignment: .leading) {
                Text("비밀번호")
                SecureField("", text: $viewModel.pw)
                    .textFieldStyle(LabelTextFieldStyle())
            }
            
            if !AuthController.getInstance().getSimpleId().isEmpty {
                Text("또는")
                    .fontWeight(.thin)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("간편인증번호")
                        
                        Spacer()
                    }
                    
                    HStack {
                        ForEach(0..<6, id: \.self) { idx in
                            AutoFocusTextField(text: $viewModel.authNumLetters[idx], isFirstResponder: viewModel.authNumCursor == idx)
                                .padding(.horizontal, 5)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(5.0)
                                .keyboardType(.numberPad)
                                .disabled(viewModel.authNumCursor != idx)
                        }
                    }
                    .frame(height: 55)
                    .highPriorityGesture(TapGesture().onEnded {
                        viewModel.resetAuthNumLetters()
                    })
                    
                    Text("다른 계정으로 간편인증번호 로그인을 이용하시려면,\n먼저 이용할 계정으로 일반로그인을 진행해주세요.")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button(action: {
                viewModel.authNumCursor = 6
                viewModel.login()
            }, label: {
                Text("로그인")
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12.0)
                    )
            })
            .disabled(!viewModel.enterValidate())
        }
        .padding()
        .onTapGesture {
            viewModel.authNumCursor = 6
        }
        .onAppear {
            viewModel.isSuccess = false
        }
        .navigationTitle("로그인")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigate(to: HomeView(), when: $viewModel.isSuccess)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

