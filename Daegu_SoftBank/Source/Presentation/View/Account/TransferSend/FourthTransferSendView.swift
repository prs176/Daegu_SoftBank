//
//  FourthTransferSendView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct FourthTransferSendView: View {
    @EnvironmentObject var navigationState: NavigationState
    
    var request: TransferSendRequest
    var fees: Int
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "checkmark.circle.fill")
                .padding(.top, 80)
            
            Text("이체완료")
                .font(.title2)
            
            Divider()
                .padding(.vertical)
            
            HStack {
                Text("받는계좌")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(BankType(rawValue: request.bank)!.description)
                        .font(.title3)
                    
                    Text(request.receiveAccountId)
                        .font(.title3)
                }
            }
            
            HStack {
                Text("보낸금액")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                
                Text("\(request.money) 원")
                    .font(.title3)
            }
            
            HStack {
                Text("수수료")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                
                Text("\(fees) 원")
                    .font(.title3)
            }
            
            Spacer()
            
            Button(action: {
                navigationState.shouldDismissToHome = true
            }, label: {
                Text("확인")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12.0)
                    )
            })
        }
        .navigationBarHidden(true)
        .padding()
    }
}

struct FourthTransferSendView_Previews: PreviewProvider {
    static var previews: some View {
        FourthTransferSendView(request: TransferSendRequest(), fees: 0)
    }
}
