//
//  FirstCreateAccountView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/10.
//

import SwiftUI

struct FirstCreateAccountView: View {
    @EnvironmentObject var navigationState: NavigationState
    @StateObject var viewModel: FirstCreateAccountViewModel = DependencyProvider.shared.container.resolve(FirstCreateAccountViewModel.self)!
    
    @State var isLoaded: Bool = true
    
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
                
                AutoFocusTextFields(count: 7, text: $viewModel.birth)
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
        .navigationTitle("계좌개설")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigate(to: SecondCreateAccountView(user: viewModel.user, request: viewModel.request), when: $viewModel.isSuccess, isDetailLink: false)
        .activeErrorToastMessage(when: $viewModel.isErrorOccurred, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct FirstCreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        FirstCreateAccountView()
    }
}
