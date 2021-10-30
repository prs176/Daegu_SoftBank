//
//  FirstAddAccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import SwiftUI

struct FirstAddAccountView: View {
    @StateObject var viewModel: FirstAddAccountViewModel = FirstAddAccountViewModel()
    
    var body: some View {
        VStack {
            Text("추가할 은행 확인")
                .font(.title2)
            
            Text("이름과 주민등록번호를 입력하세요")
                .font(.title3)
                .fontWeight(.thin)
                .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("이름")
                
                TextField("", text: $viewModel.name)
                    .textFieldStyle(LabelTextFieldStyle())
            }
            
            VStack(alignment: .leading) {
                Text("주민등록번호")
                
                HStack {
                    ForEach(0..<6, id: \.self) { idx in
                        AutoFocusTextField(text: $viewModel.rrnLetters[idx], isFirstResponder: viewModel.rnnCursor == idx)
                            .padding(.horizontal, 5)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(5.0)
                            .keyboardType(.numberPad)
                            .disabled(viewModel.rnnCursor != idx)
                    }
                
                    Image(systemName: "minus")
                        .font(.caption)
                    
                    AutoFocusTextField(text: $viewModel.rrnLetters[6], isFirstResponder: viewModel.rnnCursor == 6)
                        .padding(.vertical)
                        .padding(.horizontal, 5)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .keyboardType(.numberPad)
                        .disabled(viewModel.rnnCursor != 6)
                }
                .frame(height: 55)
                .highPriorityGesture(TapGesture().onEnded {
                    viewModel.resetRnnLetters()
                })
            }
            
            Spacer()
            
            Button(action: viewModel.refresh, label: {
                Text("조회하기")
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
        .onAppear {
            viewModel.isSuccess = false
        }
        .onTapGesture {
            viewModel.rnnCursor = 7
        }
        .navigationTitle("계좌추가")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .notDetailLinkNavigate(to: SecondAddAccountView(request: viewModel.request, accounts: viewModel.accounts), when: $viewModel.isSuccess)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct FirstAddAccountView_Previews: PreviewProvider {
    static var previews: some View {
        FirstAddAccountView()
    }
}
