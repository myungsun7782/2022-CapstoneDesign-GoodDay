//
//  PhotoCell.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/23.
//

import UIKit
import Hero

class PhotoCell: UICollectionViewCell {
    // UIImageView
    @IBOutlet weak var photoImageView: UIImageView!
    
    // UIButton
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // UIImageView
        photoImageView.layer.cornerRadius = 15
        
        // UIButton
        deleteButton.layer.cornerRadius = deleteButton.frame.height / 2
        
//        self.hero.isEnabled = true
//        self.hero.modifiers = [.fade, .scale(0.5)]
    }
}
