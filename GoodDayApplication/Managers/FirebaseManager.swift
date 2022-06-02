//
//  FirebaseManager.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/29.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage

class FirebaseManager {
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    private init() {}
    
    func uploadImage(image: UIImage, filePath: String) {
        let data = Data()
        let metaData = StorageMetadata()
        
        metaData.contentType = "image/png"
        storage.reference().child(filePath).putData(data, metadata: metaData) { (metaData, error) in if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        } else {
            print("Successfully Stored Image")
        }
        }
    }
    
    func fetchImage(filePath: String) -> UIImage {
        var image = UIImage()
        storage.reference(forURL: "gs://capstonedesign-7ade2.appspot.com/" + filePath).downloadURL { (url, error) in
            let data = NSData(contentsOf: url!)
            let img = UIImage(data: data! as Data)
            image = img!
            print("Successfully fetched Image")
        }
        return image
    }
}
