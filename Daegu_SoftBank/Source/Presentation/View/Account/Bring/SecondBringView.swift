//
//  SecondBringView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import SwiftUI

struct SecondBringView: View {
    @ObservedObject var viewModel: SecondBringViewModel
    
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    } ()
    
    init(depositAccount: TempAccount, withdrawAccount: TempAccount, request: BringRequest) {
        viewModel = SecondBringViewModel(depositAccount: depositAccount, withdrawAccount: withdrawAccount, request: request)
    }
    
    var body: some View {
        let price = Binding<String> {
            viewModel.price
        } set: { value in
            let filtered = Int(value.filter { "0123456789".contains($0) }) ?? 0
            
            if filtered > 10000000 {
                viewModel.price = "10,000,000"
                return
            }
            
            viewModel.price = formatter.string(from: NSNumber(value: filtered)) ?? "0"
        }
        
        VStack(alignment: .center) {
            HStack {
                Image("TemporaryImage")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10.0)
                
                VStack(alignment: .leading) {
                    Text(viewModel.withdrawAccount.bank)
                        .font(.title3)
                    
                    Text(viewModel.withdrawAccount.accountNum)
                        .font(.title3)
                        .fontWeight(.thin)
                }
            }
            
            HStack {
                Text("출금가능금액: ")
                
                Text("\(viewModel.withdrawAccount.balance) 원")
                    .underline()
            }
            .padding(8)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 5.0)
                    .foregroundColor(Color(.secondarySystemBackground))
            )
            .padding(.bottom)
            
            HStack {
                TextField("", text: price)
                    .font(.largeTitle)
                    .fixedSize(horizontal: true, vertical: false)
                    .keyboardType(.numberPad)
                
                Text("원")
                    .font(.largeTitle)
            }
            
            Text("\(viewModel.price.components(separatedBy: [","]).joined().numberToKorean() ?? "영") 원")
                .foregroundColor(.secondary)
            
            Spacer()
            
            Button(action: viewModel.validate) {
                Text("다음")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12.0)
                    )
            }
            .disabled(!viewModel.enterValidate())
        }
        .onAppear {
            viewModel.isSuccess = false
        }
        .padding()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("가져오기")
        .notDetailLinkNavigate(to: ThirdBringView(depositAccount: viewModel.depositAccount, request: viewModel.request), when: $viewModel.isSuccess)
        .activeErrorToastMessage(when: $viewModel.isErrorOcuured, message: viewModel.errorMessage)
        .resignKeyboardOnDragGesture()
    }
}

struct SecondBringView_Previews: PreviewProvider {
    static var previews: some View {
        SecondBringView(depositAccount: TempAccount(), withdrawAccount: TempAccount(), request: BringRequest())
    }
}
