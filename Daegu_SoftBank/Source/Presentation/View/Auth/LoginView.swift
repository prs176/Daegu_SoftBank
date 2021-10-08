//
//  LoginView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("아이디")
                TextField("아이디를 입력해주세요", text: $viewModel.id)
                    .textFieldStyle(LabelTextFieldStyle())
            }
            
            VStack(alignment: .leading) {
                Text("비밀번호")
                SecureField("비밀번호를 입력해주세요", text: $viewModel.pw)
                    .textFieldStyle(LabelTextFieldStyle())
            }
            
            Spacer()
            
            VStack {
                Button(action: {
                    viewModel.login()
                }, label: {
                    Text("로그인")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12.0)
                        )
                })
            }
        }
        .navigationTitle("아이디로 로그인")
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

