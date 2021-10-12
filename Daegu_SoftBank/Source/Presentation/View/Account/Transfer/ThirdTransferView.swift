//
//  ThirdTransferView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct ThirdTransferView: View {
    @ObservedObject var viewModel: ThirdTransferViewModel
    
    init(request: TransferRequest) {
        viewModel = ThirdTransferViewModel(request: request)
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
        .navigationTitle("송금")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct ThirdTransferView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdTransferView(request: TransferRequest())
    }
}
