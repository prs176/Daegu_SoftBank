//
//  ImageLoader.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import Foundation

class ImageLoader: ObservableObject {
    @Published var data = Data()
    
    init(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, reponse, error in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
