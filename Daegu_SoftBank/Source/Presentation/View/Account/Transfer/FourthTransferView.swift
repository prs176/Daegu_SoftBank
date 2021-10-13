//
//  FourthTransferView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct FourthTransferView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var bank: String
    var accountNum: String
    var price: Int
    var fees: Int
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "checkmark.circle.fill")
                .padding(.top, 80)
            
            Text("이체완료")
                .font(.title2)
            
            Divider()
                .padding(.vertical)
            
            HStack {
                Text("받는계좌")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(bank)
                        .font(.title3)
                    
                    Text(accountNum)
                        .font(.title3)
                }
            }
            
            HStack {
                Text("보낸금액")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                
                Text("\(price) 원")
                    .font(.title3)
            }
            
            HStack {
                Text("수수료")
                    .font(.title3)
                    .fontWeight(.thin)
                
                Spacer()
                
                
                Text("\(fees) 원")
                    .font(.title3)
            }
            
            Spacer()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("확인")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12.0)
                    )
            })
        }
        .navigationBarHidden(true)
        .padding()
    }
}

struct FourthTransferView_Previews: PreviewProvider {
    static var previews: some View {
        FourthTransferView(bank: "", accountNum: "", price: 0, fees: 0)
    }
}
