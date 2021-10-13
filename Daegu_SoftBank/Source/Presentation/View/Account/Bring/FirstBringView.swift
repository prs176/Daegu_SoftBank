//
//  FirstBringView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct FirstBringView: View {
    var accounts: [Account]
    
    var depositAccount: Account
    var request: BringRequest = BringRequest()
    
    init(depositAccount: Account, accounts: [Account]) {
        self.accounts = accounts
        
        self.request.depositAccountIdx = depositAccount.idx
        self.depositAccount = depositAccount
        
        if let idx = accounts.map({ $0.idx }).firstIndex(of: depositAccount.idx) {
            self.accounts.remove(at: idx)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("돈을 가져올 계좌를 선택하세요")
                .font(.title2)
            
            ScrollView {
                ForEach(accounts, id: \.self) { account in
                    Divider()
                    
                    NavigationLink(destination: SecondBringView(depositAccount: depositAccount, withdrawAccount: account, request: request)) {
                        SimpleAccountRow(account: account, isChecked: false)
                    }
                    .isDetailLink(false)
                    .simultaneousGesture(TapGesture().onEnded{
                        request.withdrawAccountIdx = account.idx
                    })
                }
            }
        }
        .padding()
        .navigationTitle("가져오기")
    }
}

struct FirstBringView_Previews: PreviewProvider {
    static var previews: some View {
        FirstBringView(depositAccount: Account(), accounts: [])
    }
}
