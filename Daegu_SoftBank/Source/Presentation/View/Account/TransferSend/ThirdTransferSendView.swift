//
//  ThirdTransferSendView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct ThirdTransferSendView: View {
    @StateObject var viewModel: ThirdTransferSendViewModel = DependencyProvider.shared.container.resolve(ThirdTransferSendViewModel.self)!
    
    var fees: Int
    var request: TransferSendRequest
    
    @State var isLoaded: Bool = true
    
    var body: some View {
        VStack {
            Text("계좌비밀번호를 입력하세요.")
                .font(.title2)
                .padding(.bottom, 80)
            
            AutoFocusTextFields(count: 4, text: $viewModel.pw)
            
            Spacer()
            
            Button(action: viewModel.apply, label: {
                Text("확인")
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
        .navigationTitle("이체")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigate(to: FourthTransferSendView(request: viewModel.request, fees: fees), when: $viewModel.isSuccess, isDetailLink: false)
        .activeErrorToastMessage(when: $viewModel.isErrorOccurred, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct ThirdTransferSendView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdTransferSendView(fees: 0, request: TransferSendRequest())
    }
}
