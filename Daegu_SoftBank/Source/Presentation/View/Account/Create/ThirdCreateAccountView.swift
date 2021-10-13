//
//  ThirdCreateAccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import SwiftUI

struct ThirdCreateAccountView: View {
    @ObservedObject var viewModel: ThirdCreateAccountViewModel
    
    init(request: CreateAccountRequest) {
        viewModel = ThirdCreateAccountViewModel(request: request)
    }
    
    var body: some View {
        VStack {
            Text("입출금통장 비밀번호 설정")
                .font(.title2)
                .padding(.bottom)
            
            HStack {
                ForEach(0..<4, id: \.self) { idx in
                    AutoFocusTextField(text: $viewModel.pwLetters[idx], isFirstResponder: viewModel.pwCursor == idx)
                        .padding(.horizontal, 5)
                        .frame(width: 55)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .keyboardType(.numberPad)
                        .disabled(viewModel.pwCursor != idx)
                }
            }
            .frame(height: 55)
            .highPriorityGesture(TapGesture().onEnded {
                viewModel.resetPwLetters()
            })
            
            Spacer()
            
            Button(action: viewModel.apply, label: {
                Text("개설완료")
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
        .navigationTitle("계좌개설")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .notDetailLinkNavigate(to: FourthCreateAccountView(accountInfo: viewModel.accountInfo), when: $viewModel.isSuccess)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct ThirdCreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdCreateAccountView(request: CreateAccountRequest())
    }
}
