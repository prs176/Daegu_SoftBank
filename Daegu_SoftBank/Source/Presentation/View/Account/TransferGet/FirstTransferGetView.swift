//
//  FirstTransferGetView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct FirstTransferGetView: View {
    @ObservedObject var viewModel: FirstTransferGetViewModel
    
    init(depositAccount: Account, accounts: [Account], temp: TempAccount = TempAccount(), tempAccounts: [TempAccount] = []) {
        viewModel = FirstTransferGetViewModel(accounts: tempAccounts, depositAccount: temp)
        
        if let idx = accounts.map({ $0.idx }).firstIndex(of: depositAccount.idx) {
            viewModel.accounts.remove(at: idx)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("돈을 가져올 계좌를 선택하세요")
                .font(.title2)
            
            ScrollView {
                ForEach(viewModel.accounts, id: \.self) { account in
                    Divider()
                    
                    Button {
                        viewModel.selectedAccount = account
                        viewModel.request.withdrawAccountIdx = account.idx
                        viewModel.isActiveSecondBringView = true
                    } label: {
                        SimpleAccountRow(account: account, isChecked: false)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.isActiveSecondBringView = false
        }
        .navigationTitle("가져오기")
        .notDetailLinkNavigate(to: SecondTransferGetView(depositAccount: viewModel.depositAccount, withdrawAccount: viewModel.selectedAccount, request: viewModel.request), when: $viewModel.isActiveSecondBringView)
    }
}

struct FirstTransferGetView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTransferGetView(depositAccount: Account(), accounts: [])
    }
}
