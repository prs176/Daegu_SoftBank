//
//  SimpleAccountRow.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/11.
//

import SwiftUI

struct SimpleAccountRow: View {
    var account: Account
    var isChecked: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(account.bank)
                    .foregroundColor(.secondary)
                
                Text("\(account.name) \(account.account)")
                    .fontWeight(.thin)
                    .foregroundColor(.secondary)
                
                Text("\(account.money) 원")
                    
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            if isChecked {
                Image(systemName: "checkmark")
            }
        }
    }
}


struct SimpleAccountRow_Previews: PreviewProvider {
    static var previews: some View {
        SimpleAccountRow(account: Account(), isChecked: false)
    }
}
