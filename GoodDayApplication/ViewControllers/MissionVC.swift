//
//  MissionVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/28.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class MissionVC: UIViewController {
    // Constants
    let MISSION_WEEK_BUTTON_FONT_SIZE: CGFloat = 25
    let MISSION_DAY_BUTTON_FONT_SIZE: CGFloat = 44
    let MISSION_CONTENT_VIEW_SHADOW_OPACITY: Float = 0.25
    let MISSION_DAY_LIST = ["DAY 1", "DAY 2", "DAY 3", "DAY 4", "DAY 5", "DAY 6"]
    
    // UIButton
    @IBOutlet weak var missionWeekButton: UIButton!
    
    // UICollectionView
    @IBOutlet weak var missionCollectionView: UICollectionView!
    
    // UIView
    @IBOutlet weak var missionBackgroundView: UIView!
    @IBOutlet weak var missionContentView: UIView!
    
    // UILabel
    @IBOutlet weak var missionTitleLabel: UILabel!
    @IBOutlet weak var missionContentLabel: UILabel!
    
    // Variables
    var behavior = MSCollectionViewPeekingBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        // UIButton
        configureMissionButton()
        
        // CollectionView
        configureMissionCollectionView()
        
        // UIView
        configureMissionBackgroundView()
        configureMissionContentView()
    }
    
    private func configureMissionButton() {
        missionWeekButton.titleLabel?.font = FontManager.shared.getNanumSquareR(fontSize: MISSION_WEEK_BUTTON_FONT_SIZE)
    }
    
    private func configureMissionCollectionView() {
        behavior = MSCollectionViewPeekingBehavior(cellSpacing: 0)
        behavior = MSCollectionViewPeekingBehavior(cellPeekWidth: 50)
        missionCollectionView.configureForPeekingBehavior(behavior: behavior)
        missionCollectionView.delegate = self
        missionCollectionView.dataSource = self
        missionCollectionView.register(UINib(nibName: "MissionCell", bundle: nil), forCellWithReuseIdentifier: "MissionCell")
    }
    
    private func configureMissionBackgroundView() {
        makeMissionBackgroundViewGradient()
    }
    
    private func makeMissionBackgroundViewGradient() {
        let gradientLayer = CAGradientLayer()
        let colors: [CGColor] = [
            ColorManager.shared.getThemeMain().withAlphaComponent(0).cgColor,
            ColorManager.shared.getThemeMain().withAlphaComponent(1).cgColor,
            ColorManager.shared.getThemeMain().withAlphaComponent(0.26).cgColor]
        
        gradientLayer.frame = missionBackgroundView.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        missionBackgroundView.layer.addSublayer(gradientLayer)
    }
    
    private func configureMissionContentView() {
        missionContentView.backgroundColor = ColorManager.shared.getWhite()
        missionContentView.layer.shadowOpacity = MISSION_CONTENT_VIEW_SHADOW_OPACITY
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        let notificationName = Notification.Name("sendBoolData")
        let boolDic = ["isShowFloating" : false]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: boolDic)
        dismiss(animated: true, completion: nil)
    }
}

extension MissionVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MissionCell", for: indexPath) as! MissionCell
        cell.missionDayButton.setTitle(MISSION_DAY_LIST[indexPath.row], for: .normal)
        cell.missionDayButton.titleLabel?.font = FontManager.shared.getNanumSquareB(fontSize: MISSION_DAY_BUTTON_FONT_SIZE)
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(behavior.currentIndex)
    }
}
