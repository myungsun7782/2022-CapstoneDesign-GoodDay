//
//  MissionCell.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/28.
//

import UIKit

class MissionCell: UICollectionViewCell {
    //Constants
    let MISSION_DAY_BUTTON_SHADOW_OPACITY: Float = 1
    let MISSION_DAY_BUTTON_SHADOW_RADIUS: CGFloat = 5
    
    // UIButton
    @IBOutlet weak var missionDayButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    private func initUI() {
        // UIButton
        missionDayButton.layer.cornerRadius = missionDayButton.frame.height / 2
        missionDayButton.layer.shadowColor = UIColor.gray.cgColor
        missionDayButton.layer.shadowOpacity = MISSION_DAY_BUTTON_SHADOW_OPACITY
        missionDayButton.layer.shadowOffset = CGSize.zero
        missionDayButton.layer.shadowRadius = MISSION_DAY_BUTTON_SHADOW_RADIUS
    }
}
