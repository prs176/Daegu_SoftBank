//
//  AutoFocusTextFields.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/31.
//

import SwiftUI

struct AutoFocusTextFields: View {
    var count: Int
    @Binding var text: String
    
    @State var wrappedTexts: [String]
    @FocusState var state: Int!
    
    init(count: Int, text: Binding<String>) {
        self.count = count
        self._text = text
        
        self.wrappedTexts = text.wrappedValue.compactMap({ String($0) }) + (text.wrappedValue.compactMap({ String($0) }).count..<count).map { _ in "" }
    }
    
    var body: some View {
        HStack {
            ForEach(0..<wrappedTexts.count, id: \.self) { idx in
                TextField("", text: $wrappedTexts[idx])
                    .onChange(of: wrappedTexts) { newValue in
                        guard state != nil else {
                            state = 0
                            return
                        }
                        
                        if wrappedTexts[state].count > 0 {
                            if state == wrappedTexts.count - 1 {
                                state = nil
                            }
                            else {
                                state += 1
                            }
                        }
                        else {
                            if state != 0 {
                                state -= 1
                            }
                            else {
                                state = nil
                            }
                        }
                        
                        wrappedTexts[idx] = wrappedTexts[idx].last.map(String.init) ?? ""
                        text = wrappedTexts.joined()
                    }
                    .focused($state, equals: idx)
                    .frame(maxWidth: 55)
                    .textFieldStyle(LabelTextFieldStyle())
                    .keyboardType(.numberPad)
            }
        }
        .onAppear {
            state = nil
            wrappedTexts = text.compactMap({ String($0) }) + (text.compactMap({ String($0) }).count..<count).map { _ in "" }
        }
    }
}

struct AutoFocusTextFields_Previews: PreviewProvider {
    static var previews: some View {
        AutoFocusTextFields(count: 4, text: .constant(""))
    }
}
