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
    
    init(sendAccount: Account) {
        viewModel = FirstTransferSendViewModel(sendAccount: sendAccount)
    }
    
    var body: some View {
        let money = Binding<String> {
            viewModel.money
        } set: { value in
            let filtered = Int(value.filter { "0123456789".contains($0) }) ?? 0
            
            if filtered > 10000000 {
                viewModel.money = "10,000,000"
                viewModel.request.money = 10000000
                return
            }
            
            viewModel.money = formatter.string(from: NSNumber(value: filtered)) ?? "0"
            viewModel.request.money = filtered
        }
        
        VStack(alignment: .leading, spacing: 15) {
            Text("잔액: \(viewModel.sendAccount.money) 원")
                .font(.title3)
        
            VStack(alignment: .leading) {
                Text("금액")
                
                HStack {
                    TextField("", text: money)
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
                    
                    TextField("", text: $viewModel.request.receiveAccountId)
                        .textFieldStyle(LabelTextFieldStyle())
                }
            }
            
            Spacer()
            
            Button(action: viewModel.fetch, label: {
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
        .navigate(to: SecondTransferSendView(name: viewModel.name, request: viewModel.request), when: $viewModel.isAgree, isDetailLink: false)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct FirstTransferSendView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTransferSendView(sendAccount: Account())
    }
}
