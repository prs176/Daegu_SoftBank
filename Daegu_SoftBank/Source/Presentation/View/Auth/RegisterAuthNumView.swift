//
//  RegisterAuthNumView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import SwiftUI

struct RegisterAuthNumView: View {
    @ObservedObject var viewModel: RegisterAuthNumViewModel = DependencyProvider.shared.container.resolve(RegisterAuthNumViewModel.self)!

    var uploadRequest: UploadRequest
    var registerRequest: RegisterRequest
    
    var body: some View {
        VStack {
            VStack {
                Text("마지막 단계입니다")
                    .font(.title2)
                
                Text("간편인증번호를 \(viewModel.curStep == 1 ? "재" : "")입력하세요")
                    .font(.title3)
                    .fontWeight(.thin)
            }
            .padding(.bottom, 80)
                
            
            if viewModel.curStep == 0 {
                VStack {
                    AutoFocusTextFields(texts: $viewModel.authNumLetters)
                    
                    Text("6자리 숫자를 입력하세요")
                        .fontWeight(.thin)
                    
                    Spacer()
                }
                .transition(viewModel.curStep == 0 ? .move(edge: .leading) : .move(edge: .trailing))
            }
            else {
                VStack {
                    AutoFocusTextFields(texts: $viewModel.reAuthNumLetters)
                    
                    Text("6자리 숫자를 입력하세요")
                        .fontWeight(.thin)
                    
                    Spacer()
                    
                    Button(action: viewModel.uploadImage, label: {
                        Text("가입완료")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12.0)
                            )
                    })
                    .disabled(!viewModel.enterValidate())
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.initProps()
            viewModel.update(
                uploadRequest: uploadRequest,
                registerRequest: registerRequest
            )
        }
        .onChange(of: viewModel.isSuccessUpload, perform: { isSuccessUpload in
            if isSuccessUpload {
                viewModel.register()
            }
        })
        .onChange(of: viewModel.isSuccessRegister) { isSuccessRegister in
            if isSuccessRegister {
                viewModel.registerAuthNum()
            }
        }
        .onChange(of: viewModel.isSuccessRegisterAuthNum) { isSuccessRegisterAuthNum in
            if isSuccessRegisterAuthNum {
                viewModel.login()
            }
        }
        .navigationTitle("회원가입")
        .navigationBarBackButtonHidden(viewModel.curStep == 1)
        .navigationBarItems(leading:
                                HStack {
                                    if viewModel.curStep == 1 {
                                        Button(action: {
                                            withAnimation {
                                                viewModel.curStep -= 1
                                            }
                                        }, label: {
                                            Text("이전")
                                        })
                                    }
                                },
                            trailing: HStack {
                                if viewModel.curStep == 0 {
                                    Button(action: {
                                        withAnimation {
                                            viewModel.curStep += 1
                                        }
                                    }, label: {
                                        Text("다음")
                                    })
                                    .disabled(!viewModel.enterValidate())
                                }
                            })
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigate(to: HomeView(), when: $viewModel.isSuccessLogin)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct RegisterAuthNumView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAuthNumView(uploadRequest: UploadRequest(), registerRequest: RegisterRequest())
    }
}
