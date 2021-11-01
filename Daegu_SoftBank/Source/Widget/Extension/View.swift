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
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        self.background(
            NavigationLink(isActive: binding, destination: { view }) {
                EmptyView()
            }
        )
    }
    
    func notDetailLinkNavigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        self.background(
            NavigationLink(destination: view, isActive: binding) {
                EmptyView()
            }
            .isDetailLink(false)
        )
    }
    
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
    
    func activeErrorToastMessage(when binding: Binding<Bool>, message: String?) -> some View {
        self.toast(isPresenting: binding, duration: 2.0) {
            AlertToast(displayMode: .banner(.pop), type: .error(.accentColor), title: message)
        }
    }
}
