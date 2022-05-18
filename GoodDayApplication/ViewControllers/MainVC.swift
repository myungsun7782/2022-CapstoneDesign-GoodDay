//
//  ViewController.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/11.
//

import UIKit
import FirebaseFirestore

class MainVC: UIViewController {
    // UIView
    @IBOutlet weak var missionView: UIView!
    @IBOutlet weak var famousSayingView: UIView!
    
    // UILabel
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var missionDayLabel: UILabel!
    @IBOutlet weak var missionTitleLabel: UILabel!
    @IBOutlet weak var missionFirstHashTagLabel: UILabel!
    @IBOutlet weak var missionSecondHashTagLabel: UILabel!
    
    // UIButton
    @IBOutlet weak var missionNextButton: UIButton!
    
    // Variables
    let VIEW_OPACITY: Float = 0.25
    let VIEW_RADIUS: CGFloat = 13
    let HONORIFIC_TITLE = "님,"
    let rightArrowImg = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold))
    var userName: String!
    var userUid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        // UIView
        configureMissionView()
        configureFamousSayingView()
        
        // UIButton
        configureMissionButton()
        
        // UILabel
        setUserNameLabel()
    }
    
    private func setUserNameLabel() {
        userNameLabel.text = UserDefaultsManager.shared.getUserName() + HONORIFIC_TITLE
    }
    
    private func configureMissionView() {
        missionView.layer.cornerRadius = VIEW_RADIUS
        missionView.layer.shadowOffset = CGSize(width: 0, height: 0)
        missionView.layer.shadowOpacity = VIEW_OPACITY
    }
    
    private func configureMissionButton() {
        missionNextButton.layer.cornerRadius = missionNextButton.frame.height / 2
        missionNextButton.setImage(rightArrowImg, for: .normal)
    }
    
    private func configureFamousSayingView() {
        famousSayingView.layer.cornerRadius = VIEW_RADIUS
        famousSayingView.layer.shadowOffset = CGSize(width: 0, height: 0)
        famousSayingView.layer.shadowOpacity = VIEW_OPACITY
    }
}

