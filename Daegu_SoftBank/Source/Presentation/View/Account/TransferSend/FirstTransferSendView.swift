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
        viewModel = DependencyProvider.shared.container.resolve(FirstTransferSendViewModel.self, argument: sendAccount)!
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading) {
                Text("계좌번호로 보내기")
                    .font(.title2)
                
                Text("잔액: \(viewModel.sendAccount.money) 원")
                    .foregroundColor(.secondary)
            }
        
            HStack {
                Text("금액: ")
                    .font(.title3)
                
                HStack {
                    TextField("", text: $viewModel.money)
                        .onReceive(viewModel.money.publisher) { _ in
                            let filtered = formatter.string(from: NSNumber(value: Int(viewModel.money.filter({ "0123456789".contains($0) })) ?? 0)) ?? "0"
                            
                            if Int(filtered.filter { $0 != "," }) ?? 0 > 10000000 {
                                viewModel.money = "10,000,000"
                                viewModel.request.money = 10000000
                            }
                            else if filtered != viewModel.money {
                                viewModel.money = filtered
                                viewModel.request.money = Int(filtered.filter { $0 != "," }) ?? 0
                            }
                        }
                        .font(.title3)
                        .keyboardType(.numberPad)
                    
                    Text("원")
                        .font(.title3)
                }
            }
            .padding(.top)
            
            HStack {
                HStack {
                    Picker(
                        "",
                        selection: $viewModel.bank,
                        content: {
                            ForEach(0..<["부산", "토스", "대구"].count) {
                                Text(["부산", "토스", "대구"][$0])
                            }
                        }
                    )
                    .foregroundColor(.secondary)
                }
                .padding(.trailing)
                
                TextField("계좌번호", text: $viewModel.request.receiveAccountId)
            }
            .padding(.top)
            
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
