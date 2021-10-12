//
//  FirstTransferView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct FirstTransferView: View {
    @ObservedObject var viewModel: FirstTransferViewModel
    
    var account: Account
    
    init(account: Account) {
        self.account = account
        viewModel = FirstTransferViewModel(idx: account.idx)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("잔액: \(account.balance) 원")
                .font(.title3)
        
            VStack(alignment: .leading) {
                Text("금액")
                
                TextField("", text: $viewModel.price)
                    .textFieldStyle(LabelTextFieldStyle())
                    .keyboardType(.numberPad)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("은행")
                    
                    PickerTextField(data: ["부산", "토스", "대구"], placeHolder: "", lastSelectedIdx: $viewModel.bank)
                        .frame(height: 55)
                        .fixedSize()
                }
                
                VStack(alignment: .leading) {
                    Text("계좌번호")
                    
                    TextField("", text: $viewModel.accountNum)
                        .textFieldStyle(LabelTextFieldStyle())
                }
            }
            
            Spacer()
            
            Button(action: viewModel.search, label: {
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
        .alert(isPresented: $viewModel.isSuccess) {
            Alert(title: Text("받는 사람이 맞나요?"),
                  message: Text(viewModel.name),
                  primaryButton: .cancel(Text("아니요")),
                  secondaryButton: .default(Text("예")) { viewModel.isAgree = true })
        }
        .navigationTitle("이체")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .notDetailLinkNavigate(to: SecondTransferView(name: viewModel.name, account: account, request: viewModel.request), when: $viewModel.isAgree)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct FirstTransferView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTransferView(account: Account())
    }
}
