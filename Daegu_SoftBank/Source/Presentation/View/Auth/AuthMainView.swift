//
//  AuthMainView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/06.
//

import SwiftUI

struct AuthMainView: View {
    @State var loginPresenting: Bool = false
    @State var registerPresenting: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 15) {
                VStack {
                    Text("대구소프트뱅크")
                        .padding(.top, 50)
                    
                    Text("안녕하세요")
                        .font(.title)
                }
                
                Spacer()
                
                NavigationLink(
                    isActive: $loginPresenting,
                    destination: { LoginView() },
                    label: {
                        Text("로그인")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12.0)
                            )
                    })
                
                NavigationLink(
                    isActive: $registerPresenting,
                    destination: { RegisterView() },
                    label: {
                        Text("회원가입")
                            .foregroundColor(.white)
                            .frame( maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12.0)
                            )
                    })
            }
            .padding(20)
            .navigationBarHidden(true)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .environment(\.loginViewRootPresentation, $loginPresenting)
        .environment(\.registerViewRootPresentation, $registerPresenting)
    }
}

struct AuthMainView_Previews: PreviewProvider {
    static var previews: some View {
        AuthMainView()
    }
}
