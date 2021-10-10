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
            VStack {
                Text("개인정보를 확인")
                    .font(.title)
                
                Text("이름: \(viewModel.name)")
                Text("주민등록번호: \(String(viewModel.rrn))")
                Text("전화번호: \(viewModel.phoneNum)")
            }
            .font(.title3)
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("통장별명")
                
                TextField("", text: $viewModel.accountName)
                    .textFieldStyle(LabelTextFieldStyle())
            }
            
            Spacer()
            
            NavigationLink(
                destination: ThirdCreateAccountView(request: viewModel.request),
                label: {
                    Text("확인")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12.0)
                        )
                })
                .disabled(!viewModel.enterValidate())
        }
        .padding()
        .navigationTitle("계좌개설")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .resignKeyboardOnDragGesture()
    }
}

struct SecondCreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SecondCreateAccountView(phoneNum: "", request: CreateAccountRequest())
    }
}
