//
//  HomeView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    UserInfoView(profileImage: viewModel.profileImage, name: viewModel.name)
                    
                    Menu(content: {
                        Button(action: {
                            rootPresentation.wrappedValue = false
                        }, label: {
                            Text("로그아웃")
                        })
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.primary)
                    }
                }
                
                NavigationLink(
                    destination: Text("Destination"),
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
                    Text("계좌")
                        .font(.title2)
                        .bold()
                    
                    ForEach(viewModel.accounts, id: \.self) { account in
                        Divider()
                        
                        AccountView(account: account)
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
                    destination: Text("Destination"),
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
        }
        .background(
            Color(.secondarySystemBackground).ignoresSafeArea()
        )
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
