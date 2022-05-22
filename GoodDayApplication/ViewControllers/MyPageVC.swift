//
//  MyPageVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/19.
//

import UIKit

enum MyPageEditorMode {
    case new
    case edit
}

class MyPageVC: UIViewController {
    // UIView
    @IBOutlet weak var myPageSubView: UIView!
    @IBOutlet weak var lineView: UIView!
    
    // UILabel
    @IBOutlet weak var mbtiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wakeUpTimeLabel: UILabel!
    @IBOutlet weak var sleepTimeLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var mbtiEditLabel: UILabel!
    @IBOutlet weak var wakeUpTimeEditLabel: UILabel!
    @IBOutlet weak var sleepTimeEditLabel: UILabel!
    
    // UIButton
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var mbtiEditButton: UIButton!
    @IBOutlet weak var timeEditButton: UIButton!
    
    // UIImageView
    @IBOutlet weak var myPageImageView: UIImageView!
    
    // UIStackView
    @IBOutlet weak var mbtiStackView: UIStackView!
    @IBOutlet weak var wakeUpTimeStackView: UIStackView!
    @IBOutlet weak var sleepTimeStackView: UIStackView!
    
    // Variables
    let editImage = UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .bold))
    let rightChevronImg = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        // UIView
        configureMyPageViews()
        
        // UIButton
        configureEditButtons()
        
        // UILabel
        configureEditLabels()
        
        // UIStackView
        configureEditStackViews()
    }
    
    private func configureEditButtons() {
        editButton.setImage(editImage, for: .normal)
        editButton.layer.cornerRadius = editButton.frame.height / 2
        
        mbtiEditButton.setImage(rightChevronImg, for: .normal)
        mbtiEditButton.layer.isHidden = true
        mbtiEditButton.alpha = 0
        
        timeEditButton.setImage(rightChevronImg, for: .normal)
        timeEditButton.layer.isHidden = true
        timeEditButton.alpha = 0
    }
    
    private func configureMyPageViews() {
        myPageImageView.translatesAutoresizingMaskIntoConstraints = false
        lineView.alpha = 0
    }
    
    
    private func configureEditStackViews() {
        mbtiStackView.alpha = 0
        wakeUpTimeStackView.alpha = 0
        sleepTimeStackView.alpha = 0
    }
    
    private func configureEditLabels() {
        mbtiLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mbtiLabel.text = UserDefaultsManager.shared.getMbti()
        nameLabel.text = UserDefaultsManager.shared.getUserName() + "님"
        wakeUpTimeLabel.text = TimeManager.shared.dateToHourMinString(date: UserDefaultsManager.shared.getWakeUpTime())
        sleepTimeLabel.text = TimeManager.shared
            .dateToHourMinString(date: UserDefaultsManager.shared.getSleepTime())
        
        mbtiEditLabel.text = UserDefaultsManager.shared.getMbti()
        wakeUpTimeEditLabel.text = TimeManager.shared.dateToHourMinString(date: UserDefaultsManager.shared.getWakeUpTime())
        sleepTimeEditLabel.text = TimeManager.shared
            .dateToHourMinString(date: UserDefaultsManager.shared.getSleepTime())
        
        if UserDefaultsManager.shared.getUpdateTime() == nil {
            updateTimeLabel.text = TimeManager.shared.dateToHourMinString(date: UserDefaultsManager.shared.getBeginDay())
        } else {
            if let updateTime = UserDefaultsManager.shared.getUpdateTime() {
                updateTimeLabel.text = TimeManager.shared.dateToHourMinString(date: updateTime)
            }
        }
    }
    
    // MARK: view autolayout part 나누기
    private func animateMyPageViews() {
        editButton.layer.isHidden = true
        myPageSubView.heightAnchor.constraint(equalToConstant: 420).isActive = true
        mbtiLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 142).isActive = true
        myPageImageView.widthAnchor.constraint(equalToConstant: 260).isActive = true
        myPageImageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        myPageImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 111).isActive = true
        myPageImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -15).isActive = true
    
        mbtiStackView.alpha = 1
        lineView.alpha = 1
        mbtiEditButton.layer.isHidden = false
        timeEditButton.layer.isHidden = false
        mbtiEditButton.alpha = 1
        timeEditButton.alpha = 1
        wakeUpTimeStackView.alpha = 1
        sleepTimeStackView.alpha = 1
        self.view.layoutIfNeeded() // 화면 갱신
    }
    
    private func updateTime() {
        UserDefaultsManager.shared.setUpdateTime()
        if let updateTime = UserDefaultsManager.shared.getUpdateTime() {
            updateTimeLabel.text = TimeManager.shared.dateToHourMinString(date: updateTime)
        }
    }

    @IBAction func tapEditButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.animateMyPageViews()
        } completion: { (completion) in
        }
    }
    
    @IBAction func tapMbtiEditButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "InitialSettingViews", bundle: nil)
        let mbtiSettingVC = storyboard.instantiateViewController(withIdentifier: "MbtiSettingVC") as! MbtiSettingVC
        
        mbtiSettingVC.delegate = self
        mbtiSettingVC.myPageEditorMode = .edit
        mbtiSettingVC.mbti = mbtiEditLabel.text
        
        mbtiSettingVC.modalPresentationStyle = .overFullScreen
        mbtiSettingVC.modalTransitionStyle = .crossDissolve
        present(mbtiSettingVC, animated: true, completion: nil)
    }
    
    @IBAction func tapTimeEditButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "InitialSettingViews", bundle: nil)
        let timeSettingVC = storyboard.instantiateViewController(withIdentifier: "TimeSettingVC") as! TimeSettingVC
        
        timeSettingVC.delegate = self
        timeSettingVC.myPageEditorMode = .edit
        timeSettingVC.wakeUpTime = UserDefaultsManager.shared.getWakeUpTime()
        timeSettingVC.sleepTime = UserDefaultsManager.shared.getSleepTime()
        
        timeSettingVC.modalPresentationStyle = .overFullScreen
        timeSettingVC.modalTransitionStyle = .crossDissolve
        present(timeSettingVC, animated: true, completion: nil)
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        let notificationName = Notification.Name("sendBoolData")
        let boolDic = ["isShowFloating" : false]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: boolDic)
        dismiss(animated: true, completion: nil)
    }
}

extension MyPageVC: DelegateMbtiSettingVC, DelegateTimeSettingVC {
    func passMbtiData(mbti: String) {
        updateTime()
        mbtiLabel.text = mbti
        mbtiEditLabel.text = mbti
        UserDefaultsManager.shared.setMbti(mbti: mbti)
    }
    
    func passTimeData(wakeUpTime: Date, sleepTime: Date) {
        updateTime()
        wakeUpTimeLabel.text = TimeManager.shared.dateToHourMinString(date: wakeUpTime)
        sleepTimeLabel.text = TimeManager.shared.dateToHourMinString(date: sleepTime)
        wakeUpTimeEditLabel.text = TimeManager.shared.dateToHourMinString(date: wakeUpTime)
        sleepTimeEditLabel.text = TimeManager.shared.dateToHourMinString(date: sleepTime)
        
        UserDefaultsManager.shared.setWakeUpTime(wakeUpTime: wakeUpTime)
        UserDefaultsManager.shared.setSleepTime(sleepTime: sleepTime)
    }
}
