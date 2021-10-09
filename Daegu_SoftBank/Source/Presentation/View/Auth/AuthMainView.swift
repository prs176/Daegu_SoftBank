//
//  AuthMainView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/06.
//

import SwiftUI

struct AuthMainView: View {
    @State var rootPresenting: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("안녕하세요")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
                
                NavigationLink(
                    destination: LoginView(),
                    isActive: $rootPresenting,
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
                    destination: RegisterView(),
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
            .padding()
            .navigationBarHidden(true)
        }
        .environment(\.rootPresentation, $rootPresenting)
    }
}

struct AuthMainView_Previews: PreviewProvider {
    static var previews: some View {
        AuthMainView()
    }
}
