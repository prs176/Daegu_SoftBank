//
//  SecondTransferView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct SecondTransferView: View {
    @ObservedObject var viewModel: SecondTransferViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var account: Account
    var name: String
    var request: TransferRequest
    
    init(name: String, account: Account, request: TransferRequest) {
        self.name = name
        self.account = account
        self.request = request
        viewModel = SecondTransferViewModel(price: request.price)
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Text("\(name) 에게 이체 하시겠습니까?")
                .font(.title2)
            
            Divider()
                .padding(.vertical)
        
            HStack {
                Text("출금계좌")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text(account.accountNum)
                    .font(.title3)
            }
            
            HStack {
                Text("받는계좌")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text(request.accountNum)
                    .font(.title3)
            }
            
            HStack {
                Text("보낼금액")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text("\(request.price) 원")
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
                    destination: Text(""),
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
        .navigationTitle("이체")
    }
}

struct SecondTransferView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTransferView(name: "로미", account: Account(), request: TransferRequest())
    }
}
