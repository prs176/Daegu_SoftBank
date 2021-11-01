//
//  SecondTransferGetView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct SecondTransferGetView: View {
    @ObservedObject var viewModel: SecondTransferGetViewModel
    
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    } ()
    
    init(receiveAccount: Account, sendAccount: Account, request: TransferSendRequest) {
        viewModel = SecondTransferGetViewModel(receiveAccount: receiveAccount, sendAccount: sendAccount, request: request)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image("TemporaryImage")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10.0)
                
                VStack(alignment: .leading) {
//                    Text(viewModel.sendAccount.bank)
                    Text("은행")
                        .font(.title3)
                    
                    Text(viewModel.sendAccount.account)
                        .font(.title3)
                        .fontWeight(.thin)
                }
            }
            
            HStack {
                Text("출금가능금액: ")
                
                Text("\(viewModel.sendAccount.money) 원")
                    .underline()
            }
            .padding(8)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 5.0)
                    .foregroundColor(Color(.secondarySystemBackground))
            )
            .padding(.bottom)
            
            HStack {
                TextField("", text: $viewModel.price)
                    .onReceive(viewModel.price.publisher) { _ in
                        let filtered = formatter.string(from: NSNumber(value: Int(viewModel.price.filter({ "0123456789".contains($0) })) ?? 0)) ?? "0"
                        
                        if Int(filtered.filter { $0 != "," }) ?? 0 > 10000000 {
                            viewModel.price = "10,000,000"
                            viewModel.request.money = 10000000
                        }
                        else if String(filtered) != viewModel.price {
                            viewModel.price = filtered
                            viewModel.request.money = Int(filtered.filter { $0 != "," }) ?? 0
                        }
                    }
                    .font(.largeTitle)
                    .fixedSize(horizontal: true, vertical: false)
                    .keyboardType(.numberPad)
                
                Text("원")
                    .font(.largeTitle)
            }
            
            Text("\(viewModel.price.components(separatedBy: [","]).joined().numberToKorean() ?? "영") 원")
                .foregroundColor(.secondary)
            
            Spacer()
            
            Button(action: viewModel.validate) {
                Text("다음")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12.0)
                    )
            }
            .disabled(!viewModel.enterValidate())
        }
        .onAppear {
            viewModel.isSuccess = false
        }
        .padding()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("가져오기")
        .navigate(to: ThirdTransferGetView(receiveAccount: viewModel.receiveAccount, request: viewModel.request), when: $viewModel.isSuccess, isDetailLink: false)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct SecondTransferGetView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTransferGetView(receiveAccount: Account(), sendAccount: Account(), request: TransferSendRequest())
    }
}
