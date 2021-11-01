//
//  FirstTransferGetView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct FirstTransferGetView: View {
    @ObservedObject var viewModel: FirstTransferGetViewModel
    
    @State var isActiveSecondBringView: Bool = false
    
    init(accounts: [Account], receiveAccount: Account) {
        viewModel = FirstTransferGetViewModel(accounts: accounts, receiveAccount: receiveAccount)
        
        if let idx = accounts.firstIndex(of: receiveAccount) {
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
                        viewModel.request.sendAccountId = account.account
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
        .navigate(to: SecondTransferGetView(receiveAccount: viewModel.receiveAccount, sendAccount: viewModel.selectedAccount, request: viewModel.request), when: $isActiveSecondBringView, isDetailLink: false)
    }
}

struct FirstTransferGetView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTransferGetView(accounts: [], receiveAccount: Account())
    }
}
