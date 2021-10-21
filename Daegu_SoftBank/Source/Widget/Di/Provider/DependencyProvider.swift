//
//  DependencyProvider.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/21.
//

import Swinject

class DependencyProvider {
    static let shared = DependencyProvider()
    
    let container = Container()
    let assemblr: Assembler
    
    init() {
        Container.loggingFunction = nil
        assemblr = Assembler([
            
        ], container: container)
    }
}
