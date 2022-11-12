//
//  ImageUploader.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//


import SwiftUI
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(withImage image: UIImage?, completion: @escaping (String?)-> Void) {
        guard let imageData = image?.jpegData(compressionQuality: 0.85) else { return completion(nil) }
        let ref = Storage.storage().reference(withPath: "/profile_images/\(NSUUID().uuidString)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                completion(nil)
            }
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
