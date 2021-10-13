//
//  FirstBringView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct FirstBringView: View {
    @State var isActiveSecondBringView: Bool = false
    @State var selectedAccount: Account = Account()
    
    var accounts: [Account]
    
    var depositAccount: Account
    var request: BringRequest = BringRequest()
    
    init(depositAccount: Account, accounts: [Account]) {
        self.depositAccount = depositAccount
        self.request.depositAccountIdx = depositAccount.idx
        
        self.accounts = accounts
        
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
                    
                    Button {
                        selectedAccount = account
                        request.withdrawAccountIdx = account.idx
                        isActiveSecondBringView = true
                    } label: {
                        SimpleAccountRow(account: account, isChecked: false)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            isActiveSecondBringView = false
        }
        .navigationTitle("가져오기")
        .notDetailLinkNavigate(to: SecondBringView(depositAccount: depositAccount, withdrawAccount: selectedAccount, request: request), when: $isActiveSecondBringView)
    }
}

struct FirstBringView_Previews: PreviewProvider {
    static var previews: some View {
        FirstBringView(depositAccount: Account(), accounts: [])
    }
}
