//
//  HomeView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationState: NavigationState
    @Environment(\.loginViewRootPresentation) var loginViewRootPresentation: Binding<Bool>
    @Environment(\.registerViewRootPresentation) var registerViewRootPresentation: Binding<Bool>
    @StateObject var viewModel: HomeViewModel = DependencyProvider.shared.container.resolve(HomeViewModel.self)!
    
    @State var createAccountPresenting: Bool = false
    @State var addAccountPresenting: Bool = false
    @State var transferSendPresenting: Bool = false
    @State var transferGetPresenting: Bool = false
    
    @State var selectedAccount: Account = Account()
    
    @State var isLoaded: Bool = true
    
    var body: some View {
        RefreshableScrollView(onRefresh: { control in
            viewModel.refresh()
            control.endRefreshing()
        }) {
            VStack(spacing: 20) {
                HStack {
                    UserInfoView(profileImage: viewModel.user.profileImage, name: viewModel.user.name)
                    
                    Menu(content: {
                        Button(action: {
                            AuthController.getInstance().logout()
                            loginViewRootPresentation.wrappedValue = false
                            registerViewRootPresentation.wrappedValue = false
                        }, label: {
                            Text("로그아웃")
                        })
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.primary)
                    }
                }
                
                NavigationLink(
                    isActive: $createAccountPresenting,
                    destination: { FirstCreateAccountView() },
                    label: {
                        VStack(alignment: .center) {
                            Text("계좌 개설하기")
                            
                            Image(systemName: "plus.circle")
                                .font(.title)
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color(.tertiarySystemBackground))
                        )
                    })
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("계좌")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                    }
                    
                    ForEach(viewModel.accounts, id: \.self) { account in
                        Divider()
                        
                        AccountRow(account: account, selectedAccount: $selectedAccount, transferSendPresenting: $transferSendPresenting, transferGetPresenting: $transferGetPresenting)
                            .padding(.vertical, 5)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color(.tertiarySystemBackground))
                )
                
                Spacer()
                
                NavigationLink(
                    isActive: $addAccountPresenting,
                    destination: { FirstAddAccountView() },
                    label: {
                        HStack {
                            Image(systemName: "plus")
                            
                            Text("계좌 추가하기")
                        }
                        .foregroundColor(.white)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 12.0)
                        )
                    })
            }
            .padding()
            .background(
                Color(.secondarySystemBackground).ignoresSafeArea()
            )
        }
        .background(
            Color(.secondarySystemBackground).ignoresSafeArea()
        )
        .onReceive(navigationState.$moveToHome) { moveToHome in
            if moveToHome {
                createAccountPresenting = false
                addAccountPresenting = false
                transferSendPresenting = false
                transferGetPresenting = false
                navigationState.moveToHome = false
            }
        }
        .onAppear {
            if isLoaded {
                viewModel.initProps()
                isLoaded = false
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .navigate(to: FirstTransferSendView(sendAccount: selectedAccount), when: $transferSendPresenting, isDetailLink: false)
        .navigate(to: FirstTransferGetView(accounts: viewModel.accounts, receiveAccount: selectedAccount), when: $transferGetPresenting, isDetailLink: false)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
