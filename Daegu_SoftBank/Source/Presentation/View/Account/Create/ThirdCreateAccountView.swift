//
//  ThirdCreateAccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import SwiftUI

struct ThirdCreateAccountView: View {
    @StateObject var viewModel: ThirdCreateAccountViewModel = DependencyProvider.shared.container.resolve(ThirdCreateAccountViewModel.self)!
    
    @State var isLoaded: Bool = true
    
    var request: AccountRequest
    
    var body: some View {
        VStack {
            Text("입출금통장 비밀번호 설정")
                .font(.title2)
                .padding(.bottom)
            
            AutoFocusTextFields(count: 4, text: $viewModel.pw)
            
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
        .onAppear {
            if isLoaded {
                viewModel.initProps()
                isLoaded = false
            }
            viewModel.update(request: request)
        }
        .navigationTitle("계좌개설")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigate(to: FourthCreateAccountView(accountInfo: viewModel.accountInfo), when: $viewModel.isSuccess, isDetailLink: false)
        .activeErrorToastMessage(when: $viewModel.isErrorOccurred, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct ThirdCreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdCreateAccountView(request: AccountRequest())
    }
}
