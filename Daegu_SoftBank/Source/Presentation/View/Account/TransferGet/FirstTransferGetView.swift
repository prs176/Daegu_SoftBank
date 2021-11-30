//
//  FirstTransferGetView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct FirstTransferGetView: View {
    @State var accounts: [Account]
    var receiveAccount: Account
    var request: TransferSendRequest = TransferSendRequest()
    
    @State var isAccountsEmpty = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("돈을 가져올 계좌를 선택하세요")
                .font(.title2)
            
            ScrollView {
                ForEach(accounts, id: \.self) { account in
                    Divider()
                    
                    NavigationLink(
                        destination: SecondTransferGetView(receiveAccount: receiveAccount, sendAccount: account, request: request)
                    ) {
                        SimpleAccountRow(account: account, isChecked: false)
                    }
                    .simultaneousGesture(TapGesture().onEnded { _ in
                        request.sendAccountId = account.account
                    })
                }
            }
        }
        .padding()
        .onAppear {
            request.receiveAccountId = receiveAccount.account
            request.bank = BankType.allCases.filter({ $0.description == receiveAccount.bank }).first?.rawValue ?? 0
            
            if let idx = accounts.firstIndex(of: receiveAccount) {
                accounts.remove(at: idx)
            }
            
            if accounts.count == 0 {
                isAccountsEmpty = true
            }
        }
        .activeErrorToastMessage(when: $isAccountsEmpty, message: "가져오기 할 수 있는 계좌가 없습니다.")
        .navigationTitle("가져오기")
    }
}

struct FirstTransferGetView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTransferGetView(accounts: [], receiveAccount: Account())
    }
}
