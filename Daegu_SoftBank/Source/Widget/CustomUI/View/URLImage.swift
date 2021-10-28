//
//  URLImage.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import SwiftUI

struct URLImage: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image: UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onChange(of: imageLoader.data) { data in
                image = UIImage(data: data) ?? UIImage()
            }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(withURL: "")
    }
}
