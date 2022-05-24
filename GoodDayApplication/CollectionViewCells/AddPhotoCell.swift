//
//  AddPhotoCell.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/23.
//

import UIKit

class AddPhotoCell: UICollectionViewCell {
    // Constants
    let VIEW_CORNER_RADIUS: CGFloat = 15
    let VIEW_BORDER_WIDTH: CGFloat = 1
    
    // UIView
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // UIView
        containerView.layer.cornerRadius = VIEW_CORNER_RADIUS
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = VIEW_BORDER_WIDTH
        containerView.backgroundColor = ColorManager.shared.getWhite()
    }
}
