//
//  LabelTextFieldStyle.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/06.
//

import SwiftUI

struct LabelTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(5.0)
    }
}
