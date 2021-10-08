//
//  AuthView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/06.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                Text("안녕하세요")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
                
                NavigationLink(
                    destination: RegisterView(),
                    label: {
                        Text("회원가입")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12.0)
                            )
                    })
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
