//
//  FirstBringView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct FirstBringView: View {
    var accounts: [Account]
    
    var request: BringRequest = BringRequest()
    
    init(depositAccountIdx: Int, accounts: [Account]) {
        self.request.depositAccountIdx = depositAccountIdx
        self.accounts = accounts
        
        if let idx = accounts.map({ $0.idx }).firstIndex(of: depositAccountIdx) {
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
                    
                    NavigationLink(destination: SecondBringView(withdrawAccount: account, request: request)) {
                        SimpleAccountRow(account: account, isChecked: false)
                    }
                    .onTapGesture {
                        request.withdrawAccountIdx = account.idx
                    }
                }
            }
        }
        .padding()
        .navigationTitle("계좌추가")
    }
}

struct FirstBringView_Previews: PreviewProvider {
    static var previews: some View {
        FirstBringView(depositAccountIdx: -1, accounts: [])
    }
}
