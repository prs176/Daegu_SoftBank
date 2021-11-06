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
        
        self.wrappedTexts = (0..<count).map { _ in "" }
    }
    
    var body: some View {
        HStack {
            ForEach(0..<wrappedTexts.count, id: \.self) { idx in
                TextField("", text: $wrappedTexts[idx])
                    .onChange(of: wrappedTexts) { _ in
                        if wrappedTexts.filter({ $0.count > 1 }).count != 0 {
                            wrappedTexts = wrappedTexts.map {
                                if let last = $0.last {
                                    return String(last)
                                }
                                return ""
                            }
                        }
                        text = wrappedTexts.joined()
                    }
                    .focused($state, equals: idx)
                    .frame(maxWidth: 55)
                    .textFieldStyle(LabelTextFieldStyle())
                    .keyboardType(.numberPad)
            }
        }
        .onChange(of: wrappedTexts) { _ in
            guard state != nil else {
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
        }
    }
}

struct AutoFocusTextFields_Previews: PreviewProvider {
    static var previews: some View {
        AutoFocusTextFields(count: 4, text: .constant(""))
    }
}
