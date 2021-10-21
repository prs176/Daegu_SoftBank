//
//  PickerTextField.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/12.
//

import Foundation
import SwiftUI

struct PickerTextField: UIViewRepresentable {
    let helper = Helper()
    
    var data: [String]
    var placeHolder: String
    
    @Binding var lastSelectedIdx: Int
    
    func makeUIView(context: Context) -> some UITextField {
        let textField = UITextField()
        let pickerView = UIPickerView()
        
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator
        
        textField.placeholder = placeHolder
        textField.inputView = pickerView
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        
        helper.doneButtonTapped = {
            textField.resignFirstResponder()
        }
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: helper, action: #selector(helper.doneButtonAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        return textField
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = data[lastSelectedIdx]
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(data: data) { idx in
            lastSelectedIdx = idx
        }
    }
    
    class Helper {
        public var doneButtonTapped: (() -> Void)?
        
        @objc func doneButtonAction() {
            doneButtonTapped?()
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        private var data: [String]
        private var didSelectItem: ((Int) -> Void)?
        
        init(data: [String], didSelectItem: ((Int) -> Void)? = nil) {
            self.data = data
            self.didSelectItem = didSelectItem
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return data.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return data[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            didSelectItem?(row)
        }
    }
}
