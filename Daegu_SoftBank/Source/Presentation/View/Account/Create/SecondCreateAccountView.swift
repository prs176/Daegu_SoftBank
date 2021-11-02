//
//  SecondCreateAccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import SwiftUI

struct SecondCreateAccountView: View {
    @StateObject var viewModel: SecondCreateAccountViewModel = DependencyProvider.shared.container.resolve(SecondCreateAccountViewModel.self)!
    
    @State var isLoaded: Bool = true
    
    var user: User
    var request: AccountRequest
    
    var body: some View {
        VStack {
            Text("개인정보 확인")
                .font(.title2)
            
            VStack {
                HStack {
                    Text("이름")
                        .font(.title3)
                        .fontWeight(.thin)
                    
                    Spacer()
                    
                    Text(viewModel.user.name)
                        .font(.title3)
                }
                
                HStack {
                    Text("주민등록번호")
                        .font(.title3)
                        .fontWeight(.thin)
                    
                    Spacer()
                    
                    Text(viewModel.birth)
                        .font(.title3)
                }
                
                HStack {
                    Text("전화번호")
                        .font(.title3)
                        .fontWeight(.thin)
                    
                    Spacer()
                    
                    Text(viewModel.user.phone)
                        .font(.title3)
                }
            }
            .padding(.vertical)
            
            VStack(alignment: .leading) {
                Text("통장별명")
                
                TextField("", text: $viewModel.name)
                    .textFieldStyle(LabelTextFieldStyle())
            }
            
            Spacer()
            
            NavigationLink(
                destination: { ThirdCreateAccountView(request: viewModel.request) }
            ) {
                Text("확인")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12.0)
                    )
            }
            .isDetailLink(false)
            .disabled(!viewModel.enterValidate())
        }
        .padding()
        .onAppear {
            if isLoaded {
                viewModel.initProps()
                isLoaded = false
            }
            viewModel.update(user: user, request: request)
        }
        .navigationTitle("계좌개설")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .resignKeyboardOnDragGesture()
    }
}

struct SecondCreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SecondCreateAccountView(user: User(), request: AccountRequest())
    }
}
