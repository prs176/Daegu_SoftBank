//
//  FirstCreateAccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import SwiftUI

struct FirstCreateAccountView: View {
    @StateObject var viewModel: FirstCreateAccountViewModel = DependencyProvider.shared.container.resolve(FirstCreateAccountViewModel.self)!
    
    var body: some View {
        VStack(spacing: 15) {
            VStack {
                Text("실명정보 확인")
                    .font(.title2)
                
                Text("이름과 주민등록번호를 입력하세요")
                    .fontWeight(.thin)
                    .font(.title3)
            }
            
            VStack(alignment: .leading) {
                Text("이름")
                
                TextField("", text: $viewModel.name)
                    .textFieldStyle(LabelTextFieldStyle())
            }
            
            VStack(alignment: .leading) {
                Text("주민등록번호")
                
                HStack {
                    ForEach(0..<6, id: \.self) { idx in
                        AutoFocusTextField(text: $viewModel.rrnLetters[idx], isFirstResponder: viewModel.rnnCursor == idx)
                            .padding(.horizontal, 5)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(5.0)
                            .keyboardType(.numberPad)
                            .disabled(viewModel.rnnCursor != idx)
                    }
                
                    Image(systemName: "minus")
                        .font(.caption)
                    
                    AutoFocusTextField(text: $viewModel.rrnLetters[6], isFirstResponder: viewModel.rnnCursor == 6)
                        .padding(.vertical)
                        .padding(.horizontal, 5)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .keyboardType(.numberPad)
                        .disabled(viewModel.rnnCursor != 6)
                }
                .frame(height: 55)
                .highPriorityGesture(TapGesture().onEnded {
                    viewModel.resetRnnLetters()
                })
            }
            
            Spacer()
            
            Button(action: viewModel.fetch, label: {
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
        .onAppear {
            viewModel.isSuccess = false
        }
        .onTapGesture {
            viewModel.rnnCursor = 7
        }
        .navigationTitle("계좌개설")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .notDetailLinkNavigate(to: SecondCreateAccountView(user: viewModel.user, request: viewModel.request), when: $viewModel.isSuccess)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct FirstCreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        FirstCreateAccountView()
    }
}
