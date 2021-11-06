//
//  SecondTransferSendView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct SecondTransferSendView: View {
    @EnvironmentObject var navigationState: NavigationState
    @StateObject var viewModel: SecondTransferSendViewModel = DependencyProvider.shared.container.resolve(SecondTransferSendViewModel.self)!
    
    var receiveAccount: Account
    var request: TransferSendRequest
    
    var body: some View {
        VStack(spacing: 15) {
            Text("\(viewModel.receiveAccount.name) 에게 이체 하시겠습니까?")
                .font(.title2)
                .padding(.top, 30)
            
            Divider()
                .padding(.vertical)
        
            HStack {
                Text("출금계좌")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text(viewModel.request.sendAccountId)
                    .font(.title3)
            }
            
            HStack {
                Text("받는계좌")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text(viewModel.receiveAccount.bank)
                    .font(.title3)
                
                Text(viewModel.request.receiveAccountId)
                    .font(.title3)
            }
            
            HStack {
                Text("보낼금액")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text("\(viewModel.request.money) 원")
                    .font(.title3)
            }
            
            HStack {
                Text("수수료")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text("\(viewModel.fees) 원")
                    .font(.title3)
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    navigationState.shouldDismissToHome = true
                }, label: {
                    Text("아니요")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12.0)
                                .foregroundColor(.gray)
                        )
                })
                
                NavigationLink(
                    destination: ThirdTransferSendView(fees: viewModel.fees, request: viewModel.request),
                    label: {
                        Text("예")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12.0)
                            )
                    })
                    .isDetailLink(false)
            }
        }
        .padding()
        .onAppear {
            viewModel.update(
                receiveAccount: receiveAccount,
                request: request
            )
        }
        .navigationBarHidden(true)
    }
}

struct SecondTransferSendView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTransferSendView(
            receiveAccount: Account(),
            request: TransferSendRequest()
        )
    }
}
