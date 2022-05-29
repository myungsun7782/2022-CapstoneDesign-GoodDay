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
    
    private init() {}
}
