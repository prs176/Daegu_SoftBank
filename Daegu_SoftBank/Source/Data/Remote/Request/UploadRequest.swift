//
//  UploadRequest.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/28.
//

import UIKit

class UploadRequest {
    var type: ImageType
    var name: String
    var image: UIImage?

    internal init(type: ImageType = .UNKNOWN, name: String = "", image: UIImage? = nil) {
        self.type = type
        self.name = name
        self.image = image
    }
}

enum ImageType: String {
    case JPG = "jpeg"
    case PNG = "png"
    case UNKNOWN
    
    var ext: String {
        switch (self) {
        case .JPG:
            return "jpeg"
        case .PNG:
            return "png"
        case .UNKNOWN:
            return ""
        }
    }
    
    var mimeType: String {
        switch (self) {
        case .JPG:
            return "image/jpeg"
        case .PNG:
            return "image/png"
        case .UNKNOWN:
            return ""
        }
    }
}
