//
//  SecondBringView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct SecondBringView: View {
    @ObservedObject var viewModel: SecondBringViewModel
    
    var depositAccount: Account
    var withdrawAccount: Account
    var request: BringRequest
    
    init(depositAccount: Account, withdrawAccount: Account, request: BringRequest) {
        self.depositAccount = depositAccount
        self.withdrawAccount = withdrawAccount
        self.request = request
        viewModel = SecondBringViewModel(balance: withdrawAccount.balance, request: request)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image("TemporaryImage")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10.0)
                
                VStack(alignment: .leading) {
                    Text(withdrawAccount.bank)
                        .font(.title3)
                    
                    Text(withdrawAccount.accountNum)
                        .font(.title3)
                        .fontWeight(.thin)
                }
            }
            
            HStack {
                Text("출금가능금액: ")
                
                Text("\(withdrawAccount.balance) 원")
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
                    .font(.largeTitle)
                    .fixedSize(horizontal: true, vertical: false)
                    .keyboardType(.numberPad)
                
                Text("원")
                    .font(.largeTitle)
            }
            
            Text("\(viewModel.price.numberToKorean() ?? "영") 원")
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
        .padding()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("가져오기")
        .notDetailLinkNavigate(to: ThirdBringView(depositAccount: depositAccount, request: request), when: $viewModel.isSuccess)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct SecondBringView_Previews: PreviewProvider {
    static var previews: some View {
        SecondBringView(depositAccount: Account(), withdrawAccount: Account(), request: BringRequest())
    }
}
