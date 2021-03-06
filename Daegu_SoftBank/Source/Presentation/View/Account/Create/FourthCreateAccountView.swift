//
//  FourthCreateAccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import SwiftUI

struct FourthCreateAccountView: View {
    @EnvironmentObject var navigationState: NavigationState
    
    var accountInfo: AccountInfo
    
    var body: some View {
        VStack(spacing: 15) {
            VStack {
                Text("입출금통장 개설완료")
                    .font(.title2)
                
                Text("입출금통장이 개설되었습니다.\n아래의 내용을 확인해주세요")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 30)
            
            Divider()
                .padding(.vertical)
            
            HStack {
                Text("계좌종류")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text(accountInfo.type)
                    .font(.title3)
            }
            
            HStack {
                Text("이체한도")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                Text("1일 최대 \(accountInfo.limit)원")
                    .font(.title3)
            }
            
            Spacer()
            
            Button(action: {
                navigationState.shouldDismissToHome = true
            }, label: {
                Text("완료")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
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

struct FourthCreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        FourthCreateAccountView(accountInfo: AccountInfo())
    }
}
