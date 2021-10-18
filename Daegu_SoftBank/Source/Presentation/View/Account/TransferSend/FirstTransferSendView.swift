//
//  FirstTransferSendView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct FirstTransferSendView: View {
    @ObservedObject var viewModel: FirstTransferSendViewModel
    
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    } ()
    
    init(withdrawAccount: TempAccount) {
        viewModel = FirstTransferSendViewModel(withdrawAccount: withdrawAccount)
    }
    
    var body: some View {
        let price = Binding<String> {
            viewModel.price
        } set: { value in
            let filtered = Int(value.filter { "0123456789".contains($0) }) ?? 0
            
            if filtered > 10000000 {
                viewModel.price = "10,000,000"
                return
            }
            
            viewModel.price = formatter.string(from: NSNumber(value: filtered)) ?? "0"
        }
        
        VStack(alignment: .leading, spacing: 15) {
            Text("잔액: \(viewModel.withdrawAccount.balance) 원")
                .font(.title3)
        
            VStack(alignment: .leading) {
                Text("금액")
                
                HStack {
                    TextField("", text: price)
                        .font(.title3)
                        .keyboardType(.numberPad)
                    
                    Text("원")
                        .font(.title3)
                }
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
            
            Button(action: viewModel.fetch, label: {
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
            viewModel.isAgree = false
        }
        .alert(isPresented: $viewModel.isSuccess) {
            Alert(title: Text("받는 사람이 맞나요?"),
                  message: Text(viewModel.name),
                  primaryButton: .cancel(Text("아니요")),
                  secondaryButton: .default(Text("예")) { viewModel.isAgree = true })
        }
        .navigationTitle("이체")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .notDetailLinkNavigate(to: SecondTransferSendView(name: viewModel.name, withdrawAccount: viewModel.withdrawAccount, request: viewModel.request), when: $viewModel.isAgree)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct FirstTransferSendView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTransferSendView(withdrawAccount: TempAccount())
    }
}
