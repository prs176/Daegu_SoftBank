//
//  AutoFocusTextFields.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/31.
//

import SwiftUI

struct AutoFocusTextFields: View {
    @Binding var texts: [String]
    
    @FocusState var state: Int!
    
    var body: some View {
        HStack {
            ForEach(0..<texts.count, id: \.self) { idx in
                TextField("", text: $texts[idx], onEditingChanged: { _ in
                    if texts.filter({ $0.count > 1 }).count != 0 {
                        texts = texts.map {
                            if let last = $0.last {
                                return String(last)
                            }
                            return ""
                        }
                    }
                })
                .focused($state, equals: idx)
                .frame(maxWidth: 55)
                .textFieldStyle(LabelTextFieldStyle())
                .keyboardType(.numberPad)
            }
        }
        .onChange(of: texts) { _ in
            guard state != nil else {
                return
            }
            
            if texts[state].count > 0 {
                if state == texts.count - 1 {
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
        AutoFocusTextFields(texts: .constant([]))
    }
}
