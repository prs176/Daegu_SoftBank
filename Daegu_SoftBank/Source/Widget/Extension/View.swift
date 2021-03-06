//
//  View.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/07.
//

import SwiftUI
import UIKit
import AlertToast

extension View {
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>, isDetailLink: Bool = false) -> some View {
        self.background(
            NavigationLink(isActive: binding, destination: { view }) {
                EmptyView()
            }
            .isDetailLink(isDetailLink)
        )
    }
    
    func activeErrorToastMessage(when binding: Binding<Bool>, message: String?) -> some View {
        self.toast(isPresenting: binding, duration: 2.0) {
            AlertToast(displayMode: .banner(.pop), type: .error(.accentColor), title: message)
        }
    }
    
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
