//
//  SecondBringView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct SecondBringView: View {
    var request: BringRequest
    var withdrawAccount: Account
    
    init(withdrawAccount: Account, request: BringRequest) {
        self.withdrawAccount = withdrawAccount
        self.request = request
    }
    
    var body: some View {
        VStack {
        }
    }
}

struct SecondBringView_Previews: PreviewProvider {
    static var previews: some View {
        SecondBringView(withdrawAccount: Account(), request: BringRequest())
    }
}
