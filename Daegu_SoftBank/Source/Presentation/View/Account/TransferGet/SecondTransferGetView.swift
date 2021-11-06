//
//  SecondTransferGetView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct SecondTransferGetView: View {
    @StateObject var viewModel: SecondTransferGetViewModel = DependencyProvider.shared.container.resolve(SecondTransferGetViewModel.self)!
    
    var receiveAccount: Account
    var sendAccount: Account
    var request: TransferSendRequest
    
    @State var isLoaded: Bool = true
    
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    } ()
    
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
                    .font(.largeTitle)
                    .fixedSize(horizontal: true, vertical: false)
                    .keyboardType(.numberPad)
                
                Text("원")
                    .font(.largeTitle)
            }
            
            Text("\(viewModel.money.components(separatedBy: [","]).joined().numberToKorean() ?? "영") 원")
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
            if isLoaded {
                viewModel.initProps()
                isLoaded = false
            }
            viewModel.update(
                receiveAccount: receiveAccount,
                sendAccount: sendAccount,
                request: request
            )
        }
        .padding()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("가져오기")
        .navigate(to: ThirdTransferGetView(receiveAccount: viewModel.receiveAccount, request: viewModel.request), when: $viewModel.isSuccess, isDetailLink: false)
        .activeErrorToastMessage(when: $viewModel.isErrorOccurred, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct SecondTransferGetView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTransferGetView(receiveAccount: Account(), sendAccount: Account(), request: TransferSendRequest())
    }
}
