//
//  ImagePicker.swift
//  Crasset
//
//  Created by daniele Muheim on 20.11.21.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var avatarImage: UIImage
    func makeUIViewController(context: Context) ->  UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.allowsEditing = true
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(imagePicker: self)
    }
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let imagePicker: ImagePicker
        init(imagePicker: ImagePicker) {
            self.imagePicker = imagePicker
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                imagePicker.avatarImage = image
            }
            picker.dismiss(animated: true)
        }
    }
    
}
