//
//  ImageType.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/11/06.
//

import Foundation

enum ImageType: String {
    case JPEG = "jpeg"
    case PNG = "png"
    case UNKNOWN
    
    var ext: String {
        switch (self) {
        case .JPEG:
            return "jpeg"
        case .PNG:
            return "png"
        case .UNKNOWN:
            return ""
        }
    }
    
    var mimeType: String {
        switch (self) {
        case .JPEG:
            return "image/jpeg"
        case .PNG:
            return "image/png"
        case .UNKNOWN:
            return ""
        }
    }
}
