//
//  ImagePIckerView.swift
//  BlindDate
//
//  Created by 류창휘 on 2022/12/13.
//

import SwiftUI
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var pickerImage: Image

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.allowsEditing = true
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    final class Coordinator: NSObject {
        let parent: ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
}

extension ImagePickerView.Coordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[.originalImage] as! UIImage
        let editedImage = info[.editedImage] as? UIImage
        let selectedImage = editedImage ?? originalImage
        parent.pickerImage = Image(uiImage: selectedImage)
        picker.dismiss(animated: true)
    }
}
