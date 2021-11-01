//
//  AccountRow.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import SwiftUI

struct AccountRow: View {
    var account: Account
    @Binding var selectedAccount: Account
    @Binding var transferSendPresenting: Bool
    @Binding var transferGetPresenting: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("TemporaryImage")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(10.0)
                
                VStack(alignment: .leading) {
                    Text(account.name)
                    
                    Text(account.account)
                        .fontWeight(.thin)
                }
                
                Spacer()
                
                Text("\(account.money) 원")
                    .font(.title3)
                    .bold()
            }
            
            HStack {
                Button {
                    selectedAccount = account
                    transferGetPresenting = true
                } label: {
                    Text("가져오기")
                        .foregroundColor(Color(.secondaryLabel))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color(.secondarySystemBackground))
                        )
                }
                
                Spacer()
                
                Button {
                    selectedAccount = account
                    transferSendPresenting = true
                } label: {
                    Text("이체")
                        .foregroundColor(Color(.secondaryLabel))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color(.secondarySystemBackground))
                        )
                }
            }
        }
    }
}

struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        AccountRow(account: Account(), selectedAccount: .constant(Account()), transferSendPresenting: .constant(false), transferGetPresenting: .constant(false))
    }
}
