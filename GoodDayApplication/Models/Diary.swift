//
//  Diary.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/25.
//

import Foundation
import UIKit

class Diary {
    var title: String!
    var contents: String!
    var date: String!
    var photoList: [UIImage]!
    
    init(title: String, contents: String, date: String, photoList: [UIImage]) {
        self.title = title
        self.contents = contents
        self.date = date
        self.photoList = photoList
    }
}
