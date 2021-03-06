//
//  FirstAddAccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import SwiftUI

struct FirstAddAccountView: View {
    @EnvironmentObject var navigationState: NavigationState
    @StateObject var viewModel: FirstAddAccountViewModel = DependencyProvider.shared.container.resolve(FirstAddAccountViewModel.self)!
    
    @State var isLoaded: Bool = true
    
    var body: some View {
        VStack {
            Text("추가할 은행 확인")
                .font(.title2)
            
            Text("이름과 주민등록번호를 입력하세요")
                .font(.title3)
                .fontWeight(.thin)
                .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("이름")
                
                TextField("", text: $viewModel.name)
                    .textFieldStyle(LabelTextFieldStyle())
            }
            
            VStack(alignment: .leading) {
                Text("주민등록번호")
                
                AutoFocusTextFields(count: 7, text: $viewModel.birth)
            }
            
            Spacer()
            
            Button(action: viewModel.fetch, label: {
                Text("조회하기")
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
            if isLoaded {
                viewModel.initProps()
                isLoaded = false
            }
            viewModel.update()
        }
        .alert(isPresented: $viewModel.isFailure) {
            Alert(
                title: Text("유저정보 조회에 실패했습니다."),
                dismissButton: .destructive(Text("뒤로")) {
                    viewModel.isFailure = false
                    navigationState.shouldDismissToHome = true
                }
            )
        }
        .navigationTitle("계좌추가")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigate(to: SecondAddAccountView(accounts: viewModel.accounts), when: $viewModel.isSuccess, isDetailLink: false)
        .activeErrorToastMessage(when: $viewModel.isErrorOccurred, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct FirstAddAccountView_Previews: PreviewProvider {
    static var previews: some View {
        FirstAddAccountView()
    }
}
