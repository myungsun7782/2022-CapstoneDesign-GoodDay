//
//  ViewController.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/11.
//

/**
 //    func uploadImage(img: UIImage) {
 //        var data = Data()
 //        data = img.jpegData(compressionQuality: 0.8)!
 //        let filePath = "image"
 //        let metaData = StorageMetadata()
 //        metaData.contentType = "image/png"
 //        storage.reference().child(filePath).putData(data, metadata: metaData) { (metaData, error) in if let error = error {
 //            print(error.localizedDescription)
 //            return
 //        }else {
 //            print("성공")
 //        }
 //        }
 //    }
 //
 //    func downloadImage(imgView: UIImageView) {
 //        storage.reference(forURL: "gs://capstonedesign-7ade2.appspot.com/image").downloadURL //            { (url, error) in
 //            let data = NSData(contentsOf: url!)
 //            let image = UIImage(data: data! as Data)
 //            print("download success!!")
 //            print("url: \(url?.description)")
 //            imgView.image = image
 //
 //        }
 //    }
**/

import UIKit
import Lottie
import FirebaseStorage

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
    @IBOutlet weak var famousSayingLabel: UILabel!
    
    // UIButton
    @IBOutlet weak var missionNextButton: UIButton!
    
    // Variables
    let VIEW_OPACITY: Float = 0.25
    let VIEW_RADIUS: CGFloat = 13
    let HONORIFIC_TITLE = "님,"
    let rightArrowImg = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold))
    let animationView = AnimationView(name: "30344-hamburger-close-animation")
    let ANIMATION_VIEW_SIZE: CGFloat = 32
    let DEFAULT_FAMOUS_SAYING_TITLE = "잘 시작하는 것도 훌룡한 것이지만, 잘 끝내는 것은 더 훌룡한 일이다."
    let FAMOUS_SAYING_LABEL_LINE_SPACING: CGFloat = 4
    var isShowFloating: Bool = true
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
        configureFamousSayingLabel()
        
        // AnimationView
        configureAnimationView()
        
        // NotificationCenter
        configureNotificationCenter()
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
    
    private func configureAnimationView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        animationView.addGestureRecognizer(tapGesture)
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        constrainAnimationView()
    }
    
    private func constrainAnimationView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -27).isActive = true
        animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 37).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: ANIMATION_VIEW_SIZE).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: ANIMATION_VIEW_SIZE).isActive = true
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        if isShowFloating {
            animationView.play()
            animationView.animationSpeed = 5
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let floatingButtonVC = storyboard.instantiateViewController(withIdentifier: "FloatingButtonVC") as! FloatingButtonVC
            
            floatingButtonVC.modalPresentationStyle = .overCurrentContext
            
            floatingButtonVC.delegate = self
            present(floatingButtonVC, animated: false, completion: nil)
        }
    }
    
    private func configureNotificationCenter() {
        let notificationName = Notification.Name("sendBoolData")
        NotificationCenter.default.addObserver(self, selector: #selector(sendBoolData), name: notificationName, object: nil)
    }
    
    @objc private func sendBoolData(notification: Notification) {
        isShowFloating = notification.userInfo?["isShowFloating"] as? Bool ?? false
        if !isShowFloating {
            animationView.play(fromFrame: animationView.animation?.endFrame, toFrame: animationView.animation!.startFrame)
            isShowFloating = true
        }
    }
    
    private func configureFamousSayingLabel() {
        famousSayingLabel.text = DEFAULT_FAMOUS_SAYING_TITLE
        let attrString = NSMutableAttributedString(string: famousSayingLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = FAMOUS_SAYING_LABEL_LINE_SPACING
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        famousSayingLabel.attributedText = attrString
    }
}

extension MainVC: DelegateFloatingButtonVC {
    func passBoolValue(isShowFloating: Bool) {
        self.isShowFloating = isShowFloating
        
        if !self.isShowFloating {
            animationView.play(fromFrame: animationView.animation?.endFrame, toFrame: animationView.animation!.startFrame)
            self.isShowFloating = true
        }
    }
}

