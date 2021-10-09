//
//  AccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import SwiftUI

struct AccountView: View {
    var account: Account
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(account.name)
                    
                    Text(account.accountNum)
                        .font(.callout)
                }
                
                Spacer()
                
                Text("\(account.balance) 원")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .bold()
            }
            .padding(.bottom)
            
            HStack {
                NavigationLink(destination: Text("asdf"), label: {
                    Text("가져오기")
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.secondary.opacity(0.15))
                        )
                })
                
                Spacer()
                
                NavigationLink(destination: Text("asdf"), label: {
                    Text("이체")
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.secondary.opacity(0.15))
                        )
                })
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(account: Account(idx: 0, accountNum: "123-41234", name: "로미 통장", balance: 50000))
    }
}
