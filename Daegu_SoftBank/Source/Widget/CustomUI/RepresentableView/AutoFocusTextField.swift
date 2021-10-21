//
//  AutoFocusTextField.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import SwiftUI

struct AutoFocusTextField: UIViewRepresentable {
    @Binding var text: String
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<AutoFocusTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.keyboardType = .numberPad
        
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<AutoFocusTextField>) {
        uiView.text = text
        if isFirstResponder {
            uiView.becomeFirstResponder()
        }
        else {
            uiView.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> AutoFocusTextField.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        let parent: AutoFocusTextField

        init(_ parent: AutoFocusTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
