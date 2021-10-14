//
//  FirstBringView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct FirstBringView: View {
    @ObservedObject var viewModel: FirstBringViewModel
    
    init(depositAccount: TempAccount, accounts: [TempAccount]) {
        viewModel = FirstBringViewModel(accounts: accounts, depositAccount: depositAccount)
        
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
        .notDetailLinkNavigate(to: SecondBringView(depositAccount: viewModel.depositAccount, withdrawAccount: viewModel.selectedAccount, request: viewModel.request), when: $viewModel.isActiveSecondBringView)
    }
}

struct FirstBringView_Previews: PreviewProvider {
    static var previews: some View {
        FirstBringView(depositAccount: TempAccount(), accounts: [])
    }
}
