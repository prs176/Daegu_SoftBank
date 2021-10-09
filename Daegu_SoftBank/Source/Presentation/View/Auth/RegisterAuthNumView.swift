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
        ZStack {
            if viewModel.curStep == 0 {
                VStack {
                    Text("마지막 단계입니다")
                        .font(.title)
                    
                    Text("간편인증번호를 입력하세요")
                        .font(.title3)
                    
                    Spacer()
                    
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
                    .onTapGesture {
                        viewModel.resetAuthNumLetters()
                    }
                    .frame(height: 50)
                    
                    Text("6자리 숫자를 입력하세요")
                        .fontWeight(.thin)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.authNumCursor = 6
                        withAnimation {
                            viewModel.curStep += 1
                        }
                    }, label: {
                        Text("다음")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12.0)
                            )
                    })
                    .disabled(!viewModel.enterValidate())
                }
                .transition(viewModel.curStep == 0 ? .move(edge: .leading) : .move(edge: .trailing))
            }
            else {
                VStack {
                    Text("마지막 단계입니다")
                        .font(.title)
                    
                    Text("간편인증번호를 재입력하세요")
                        .font(.title3)
                    
                    Spacer()
                    
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
                    .onTapGesture {
                        viewModel.resetAuthNumLetters()
                    }
                    .frame(height: 50)
                    
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
        .navigationTitle("간편인증번호 등록")
        .navigationBarTitleDisplayMode(.inline)
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
                                })
        .navigationBarBackButtonHidden(viewModel.curStep == 1)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct RegisterAuthNumView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAuthNumView()
    }
}
