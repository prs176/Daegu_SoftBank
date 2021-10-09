//
//  BaseViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import Foundation

class BaseViewModel: ObservableObject {
    @Published var errorMessage = "알 수 없는 오류가 발생했습니다."
    @Published var isErrorOcuured = false
}
