//
//  ThirdTransferGetView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/13.
//

import SwiftUI

struct ThirdTransferGetView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: ThirdTransferGetViewModel
    
    init(receiveAccount: Account, request: TransferSendRequest) {
        viewModel = ThirdTransferGetViewModel(receiveAccount: receiveAccount, request: request)
    }
    
    var body: some View {
        VStack {
            Text("계좌비밀번호를 입력하세요.")
                .font(.title)
                .padding(.bottom, 80)
            
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
        .alert(isPresented: $viewModel.isSuccess) {
            Alert(title: Text("가져오기 완료"),
                  message: Text("\(viewModel.receiveAccount.name)(으)로\n\(viewModel.request.money) 원을 가져왔습니다."),
                  dismissButton: .cancel(Text("확인")) { presentationMode.wrappedValue.dismiss() })
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
