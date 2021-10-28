//
//  PhotoPicker.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/06.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    let configuration: PHPickerConfiguration
    @Binding var photo: UIImage?
    @Binding var name: String
    @Binding var type: ImageType

    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let itemProvider = results.first?.itemProvider {
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        DispatchQueue.main.async { [weak self] in
                            self?.parent.photo = image as? UIImage
                        }
                    }
                }
                itemProvider.loadFileRepresentation(forTypeIdentifier: "public.item") { url, error in
                    DispatchQueue.main.async { [weak self] in
                        self?.parent.name = url?.lastPathComponent ?? ""
                        self?.parent.type = ImageType(rawValue: url?.pathExtension ?? "") ?? ImageType.UNKNOWN
                    }
                }
            }
            
            picker.dismiss(animated: true)
        }
    }
}
