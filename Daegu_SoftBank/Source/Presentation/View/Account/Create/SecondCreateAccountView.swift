//
//  SecondCreateAccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import SwiftUI

struct SecondCreateAccountView: View {
    @ObservedObject var viewModel: SecondCreateAccountViewModel
    
    init(phoneNum: String, request: CreateAccountRequest) {
        viewModel = SecondCreateAccountViewModel(phoneNum: phoneNum, request: request)
    }
    
    var body: some View {
        VStack {
            Text("개인정보를 확인하세요")
                .font(.title3)
            
            VStack {
                Text("이름: \(viewModel.request.name)")
                Text("주민등록번호: \(viewModel.request.rrn)")
                Text("전화번호: \(viewModel.phoneNum)")
            }
        }
    }
}

struct SecondCreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SecondCreateAccountView(phoneNum: "", request: CreateAccountRequest())
    }
}
