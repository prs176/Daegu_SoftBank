//
//  RegisterAuthNumView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import SwiftUI

struct RegisterAuthNumView: View {
    @StateObject var viewModel = RegisterAuthNumViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Text("마지막 단계입니다")
                    .font(.title)
                
                Text("간편인증번호를 \(viewModel.curStep == 1 ? "재" : "")입력하세요")
                    .font(.title3)
            }
            .padding(.bottom, 80)
                
            
            if viewModel.curStep == 0 {
                VStack {
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
                    
                    Text("6자리 숫자를 입력하세요")
                        .fontWeight(.thin)
                    
                    Spacer()
                }
                .transition(viewModel.curStep == 0 ? .move(edge: .leading) : .move(edge: .trailing))
            }
            else {
                VStack {
                    HStack {
                        ForEach(0..<6, id: \.self) { idx in
                            AutoFocusTextField(text: $viewModel.reAuthNumLetters[idx], isFirstResponder: viewModel.authNumCursor == idx)
                                .padding(.horizontal, 5)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(5.0)
                                .keyboardType(.numberPad)
                                .disabled(viewModel.authNumCursor != idx)
                        }
                    }
                    .frame(height: 50)
                    .highPriorityGesture(TapGesture().onEnded {
                        viewModel.resetAuthNumLetters()
                    })
                    
                    Text("6자리 숫자를 입력하세요")
                        .fontWeight(.thin)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.authNumCursor = 6
                        viewModel.registerAuthNum()
                    }, label: {
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
        .onTapGesture {
            viewModel.authNumCursor = 6
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
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
                                        viewModel.authNumCursor = 6
                                        withAnimation {
                                            viewModel.curStep += 1
                                        }
                                    }, label: {
                                        Text("다음")
                                    })
                                    .disabled(!viewModel.enterValidate())
                                }
                            })
        .navigate(to: HomeView(), when: $viewModel.isSuccess)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct RegisterAuthNumView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAuthNumView()
    }
}
