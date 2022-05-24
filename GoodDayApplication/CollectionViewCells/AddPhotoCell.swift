//
//  AddPhotoCell.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/23.
//

import UIKit

class AddPhotoCell: UICollectionViewCell {
    // UIView
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // UIView
        containerView.layer.cornerRadius = 15
    }
}
