//
//  SecondAddAccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/11.
//

import SwiftUI

struct SecondAddAccountView: View {
    @EnvironmentObject var navigationState: NavigationState
    @StateObject var viewModel: SecondAddAccountViewModel = DependencyProvider.shared.container.resolve(SecondAddAccountViewModel.self)!
    
    var accounts: [Account]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(Set(viewModel.accounts.map({ $0.bank })).count) 개의 은행에서\n\(viewModel.accounts.count) 개의 계좌를 찾았습니다.")
                .font(.title2)
            
            Text("등록할 계좌를 선택해주세요.\n등록된 계좌는 간편하게 송금 및 조회할 수 있습니다.")
                .font(.title3)
                .fontWeight(.thin)
            
            ScrollView {
                ForEach(viewModel.accounts, id: \.self) { account in
                    Divider()
                    
                    Button(action: {
                        if viewModel.selectedAccounts.contains(account.account) {
                            viewModel.selectedAccounts.remove(at: viewModel.selectedAccounts.firstIndex(of: account.account)!)
                        }
                        else {
                            viewModel.selectedAccounts.append(account.account)
                        }
                    }, label: {
                        SimpleAccountRow(account: account, isChecked: viewModel.selectedAccounts.contains(account.account))
                    })
                }
            }
            
            Spacer()
            
            Button(action: viewModel.apply, label: {
                Text("확인")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12.0)
                    )
            })
            .disabled(!viewModel.enterValidate())
        }
        .padding()
        .onAppear {
            viewModel.update(accounts: accounts)
        }
        .onChange(of: viewModel.isSuccess, perform: { value in
            if value {
                navigationState.shouldDismissToHome = true
            }
        })
        .navigationTitle("계좌추가")
        .activeErrorToastMessage(when: $viewModel.isErrorOccurred, message: viewModel.errorMessage)
    }
}

struct SecondAddAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SecondAddAccountView(accounts: [Account(idx: 0, account: "123123", name: "로미은행", money: 32, userId: "asdf", bank: "카카오")])
    }
}
