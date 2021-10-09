//
//  RegisterAuthNumView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import SwiftUI

struct RegisterAuthNumView: View {
    @StateObject var viewModel = RegisterAuthNumViewModel()
    
    var body: some View {
        VStack {
            Text("마지막 단계입니다")
                .font(.title)
            
            Text("간편인증번호를 입력하세요")
                .font(.title)
            
            Spacer()
            
            HStack {
                ForEach(0..<6, id: \.self) { idx in
                    AutoFocusTextField(text: $viewModel.authNumLetters[idx], isFirstResponder: viewModel.authNumCursor == idx)
                        .padding(.vertical)
                        .padding(.horizontal, 5)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .keyboardType(.numberPad)
                        .disabled(viewModel.authNumCursor != idx)
                }
            }
            .onTapGesture {
                viewModel.resetAuthLetters()
            }
            .frame(height: 50)
            
            Text("6자리 숫자를 입력하세요")
                .fontWeight(.thin)
            
            Spacer()
            
            Button(action: {
                viewModel.registerAuthNum()
            }, label: {
                Text("가입완료")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12.0)
                    )
            })
        }
        .padding()
        .resignKeyboardOnDragGesture()
    }
}

struct RegisterAuthNumView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAuthNumView()
    }
}
