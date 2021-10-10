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

struct CreateAccountViewRootPresentationKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

struct AddAccountViewRootPresentationKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

struct TransferViewRootPresentationKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

struct BringViewRootPresentationKey: EnvironmentKey {
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
    
    var createAccountViewRootPresentation: Binding<Bool> {
        get {
            self[CreateAccountViewRootPresentationKey.self]
        }
        set {
            self[CreateAccountViewRootPresentationKey.self] = newValue
        }
    }
    
    var addAccountViewRootPresentation: Binding<Bool> {
        get {
            self[AddAccountViewRootPresentationKey.self]
        }
        set {
            self[AddAccountViewRootPresentationKey.self] = newValue
        }
    }
    
    var transferViewRootPresentation: Binding<Bool> {
        get {
            self[TransferViewRootPresentationKey.self]
        }
        set {
            self[TransferViewRootPresentationKey.self] = newValue
        }
    }
    
    var bringViewRootPresentationKey: Binding<Bool> {
        get {
            self[BringViewRootPresentationKey.self]
        }
        set {
            self[BringViewRootPresentationKey.self] = newValue
        }
    }
}
