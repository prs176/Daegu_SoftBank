//
//  AddAccountRow.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/11.
//

import SwiftUI

struct AddAccountRow: View {
    var account: Account
    var isChecked: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(account.bank)
                    .foregroundColor(.secondary)
                
                Text("\(account.name) \(account.accountNum)")
                    .fontWeight(.thin)
                    .foregroundColor(.secondary)
                
                Text("\(account.balance) 원")
                    
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            if isChecked {
                Image(systemName: "checkmark")
            }
        }
    }
}

struct AddAccountRow_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountRow(account: Account(idx: 0, accountNum: "1234-1234", bank: "안녕", name: "안녕", balance: 2341), isChecked: false)
    }
}
