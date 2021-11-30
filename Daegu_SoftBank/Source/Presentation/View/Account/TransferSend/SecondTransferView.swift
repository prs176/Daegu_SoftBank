//
//  SecondTransferSendView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct SecondTransferSendView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: SecondTransferViewModel
    
    init(name: String, withdrawAccount: TempAccount, request: TransferRequest) {
        viewModel = SecondTransferViewModel(name: name, withdrawAccount: withdrawAccount, request: request)
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Text("\(viewModel.name) 에게 이체 하시겠습니까?")
                .font(.title2)
                .padding(.top, 30)
            
            Divider()
                .padding(.vertical)
        
            HStack {
                Text("출금계좌")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text(viewModel.withdrawAccount.accountNum)
                    .font(.title3)
            }
            
            HStack {
                Text("받는계좌")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text(viewModel.request.bank)
                    .font(.title3)
                
                Text(viewModel.request.accountNum)
                    .font(.title3)
            }
            
            HStack {
                Text("보낼금액")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text("\(viewModel.request.price) 원")
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
                    presentationMode.wrappedValue.dismiss()
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
                    destination: ThirdTransferView(fees: viewModel.fees, request: viewModel.request),
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
        .notDetailLinkNavigate(to: ThirdTransferView(fees: viewModel.fees, request: viewModel.request), when: .constant(false))
        .navigationBarHidden(true)
    }
}

struct SecondTransferSendView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTransferSendView(name: "로미", withdrawAccount: TempAccount(), request: TransferRequest())
    }
}
