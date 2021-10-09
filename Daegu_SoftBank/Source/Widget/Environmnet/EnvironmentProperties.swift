//
//  EnvironmentProperties.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import SwiftUI

struct LoginViewRootPresentationKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

struct RegisterViewRootPresentationKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var loginViewRootPresentation: Binding<Bool> {
        get {
            self[LoginViewRootPresentationKey.self]
        }
        set {
            self[LoginViewRootPresentationKey.self] = newValue
        }
    }
    
    var registerViewRootPresentation: Binding<Bool> {
        get {
            self[RegisterViewRootPresentationKey.self]
        }
        set {
            self[RegisterViewRootPresentationKey.self] = newValue
        }
    }
}
