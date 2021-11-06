//
//  BaseViewModel.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import Combine

class BaseViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var isErrorOccurred = false
    
    var bag = Set<AnyCancellable>()
    
    func addCancellable<T>(
        publisher: AnyPublisher<T, Error>,
        onReceiveValue: @escaping (T) -> Void,
        onReceiveFailure: ((Error) -> Void)? = nil
    ) {
        isLoading = true
        publisher
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        if let onReceiveFailure = onReceiveFailure {
                            onReceiveFailure(error)
                        }
                        
                        if let error = error as? SoftBankError,
                           case let .error(message, _, _) = error {
                            self?.errorMessage = message
                        }
                        else {
                            self?.errorMessage = "알 수 없는 오류가 발생했습니다."
                        }
                        
                        self?.isErrorOccurred = true
                    }
                    self?.isLoading = false
                },
                receiveValue: onReceiveValue
            )
            .store(in: &bag)
    }
}
