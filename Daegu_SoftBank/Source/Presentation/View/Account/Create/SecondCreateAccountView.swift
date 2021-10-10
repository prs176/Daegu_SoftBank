//
//  SecondCreateAccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import SwiftUI

struct SecondCreateAccountView: View {
    @ObservedObject var viewModel: SecondCreateAccountViewModel
    
    var name: String
    var rrn: String
    var phoneNum: String
    
    init(phoneNum: String, request: CreateAccountRequest) {
        viewModel = SecondCreateAccountViewModel(request: request)
        
        name = request.name
        
        let temp = String(request.rrn)
        rrn = String(temp[temp.startIndex..<temp.index(temp.endIndex, offsetBy: -1)]) + "-" + String(temp.last!)
        
        self.phoneNum = phoneNum
    }
    
    var body: some View {
        VStack {
            Text("개인정보 확인")
                .font(.title)
            
            VStack {
                HStack {
                    Text("이름")
                        .font(.title3)
                        .fontWeight(.thin)
                    
                    Spacer()
                    
                    Text(name)
                        .font(.title3)
                }
                
                HStack {
                    Text("주민등록번호")
                        .font(.title3)
                        .fontWeight(.thin)
                    
                    Spacer()
                    
                    Text(rrn)
                        .font(.title3)
                }
                
                HStack {
                    Text("전화번호")
                        .font(.title3)
                        .fontWeight(.thin)
                    
                    Spacer()
                    
                    Text(phoneNum)
                        .font(.title3)
                }
            }
            .padding(.vertical)
            
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
                .isDetailLink(false)
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
