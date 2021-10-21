//
//  LoginView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel(loginUseCase: LoginUseCase(userRepository: UserRepositoryImpl(userRemote: UserRemote())), loginByAuthNumUseCase: LoginByAuthNumUseCase(authNumRepository: AuthNumRepositoryImpl(authNumRemote: AuthNumRemote())), fetchMyAuthNumUseCase: FetchMyAuthNumUseCase(authNumRepository: AuthNumRepositoryImpl(authNumRemote: AuthNumRemote())))
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading) {
                Text("아이디")
                TextField("", text: $viewModel.id)
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
                    Text("간편인증번호")
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
        .navigationTitle("로그인")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onChange(of: viewModel.isSuccess, perform: { value in
            if value {
                viewModel.fetchPresenceOfMyAuthNum()
            }
        })
        .navigate(to: HomeView(), when: $viewModel.shouldMoveToHomeView)
        .navigate(to: RegisterAuthNumView(), when: $viewModel.shouldRegisterAuthNumView)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

