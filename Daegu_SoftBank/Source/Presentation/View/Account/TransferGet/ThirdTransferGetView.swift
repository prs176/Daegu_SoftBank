//
//  ThirdTransferGetView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/13.
//

import SwiftUI

struct ThirdTransferGetView: View {
    @EnvironmentObject var navigationState: NavigationState
    @StateObject var viewModel: ThirdTransferGetViewModel = DependencyProvider.shared.container.resolve(ThirdTransferGetViewModel.self)!
    
    var receiveAccount: Account
    var request: TransferSendRequest
    
    var body: some View {
        VStack {
            Text("계좌비밀번호를 입력하세요.")
                .font(.title)
                .padding(.bottom, 80)
            
            AutoFocusTextFields(texts: $viewModel.pwLetters)
            
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
            viewModel.initProps()
            viewModel.update(request: request)
        }
        .alert(isPresented: $viewModel.isSuccess) {
            Alert(
                title: Text("가져오기 완료"),
                message: Text("\(receiveAccount.name)(으)로\n\(viewModel.request.money) 원을 가져왔습니다."),
                dismissButton: .cancel(Text("확인")) {
                    navigationState.shouldDismissToHome = true
                }
            )
        }
        .navigationTitle("이체")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct ThirdTransferGetView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdTransferGetView(receiveAccount: Account(), request: TransferSendRequest())
    }
}
