//
//  FloatingButtonVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/18.
//

import UIKit
import Lottie

protocol DelegateFloatingButtonVC: AnyObject {
    func passBoolValue(isShowFloating: Bool)
}

class FloatingButtonVC: UIViewController {
    // UIButton
    @IBOutlet weak var missionButton: UIButton!
    @IBOutlet weak var diaryButton: UIButton!
    @IBOutlet weak var myPageButton: UIButton!
    
    // UIView
    @IBOutlet var floatingView: UIView!

    // NSLayoutConstraint
    @IBOutlet weak var missionButtonCenterY: NSLayoutConstraint!
    @IBOutlet weak var missionLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var missionLabelCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var diaryButtonCenterY: NSLayoutConstraint!
    @IBOutlet weak var diaryLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var diaryLabelCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var myPageButtonCenterY: NSLayoutConstraint!
    @IBOutlet weak var myPageLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var myPageLabelCenterY: NSLayoutConstraint!
    
    // Variables
    let missionImg = UIImage(systemName: "target", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
    let diaryImg = UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
    let myPageImg = UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
    let animationView = AnimationView(name: "30344-hamburger-close-animation")
    let BUTTON_SHADOW_OPACITY: Float = 1
    let BUTTON_SHADOW_RADIUS: CGFloat = 5
    let ANIMATION_VIEW_SIZE: CGFloat = 32
    let FLOATING_VIEW_ALPHA: CGFloat = 0.65
    weak var delegate: DelegateFloatingButtonVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.missionButtonCenterY.constant = 60
            self.diaryButtonCenterY.constant = 120
            self.myPageButtonCenterY.constant = 180

            self.missionLabelCenterY.constant = 60
            self.diaryLabelCenterY.constant = 120
            self.myPageLabelCenterY.constant = 180

            self.missionLabelCenterX.constant = -47
            self.diaryLabelCenterX.constant = -55
            self.myPageLabelCenterX.constant = -70

            self.view.layoutIfNeeded() // 화면 갱신
        } completion: { (completion) in
        }
    }
    
    private func initUI() {
        // AnimationView
        configureAnimationView()
        
        // FloatingButton
        constrainFloatingButton()
        configureButtons()
    }
    
    private func configureAnimationView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        animationView.addGestureRecognizer(tapGesture)
        view.addSubview(animationView)
        constrainAnimationView()
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.animationSpeed = 5
    }
    
    private func constrainAnimationView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -27).isActive = true
        animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 37).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: ANIMATION_VIEW_SIZE).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: ANIMATION_VIEW_SIZE).isActive = true
    }
    
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        finishAnimationView()
    }

    private func constrainFloatingButton() {
        missionButtonCenterY.constant = 0
        diaryButtonCenterY.constant = 0
        myPageButtonCenterY.constant = 0
        
        missionLabelCenterY.constant = 0
        diaryLabelCenterY.constant = 0
        myPageLabelCenterY.constant = 0
        
        missionLabelCenterX.constant = 0
        diaryLabelCenterX.constant = 0
        myPageLabelCenterX.constant = 0
        
        floatingView.backgroundColor = .black
        floatingView.alpha = FLOATING_VIEW_ALPHA
    }
    
    private func configureButtons() {
        // TODO: Buttons addTarget 추가 -> 화면 이동
    
        // Mission Button
        missionButton.setImage(missionImg, for: .normal)
        missionButton.layer.cornerRadius = missionButton.frame.height / 2
        missionButton.layer.shadowColor = UIColor.gray.cgColor
        missionButton.layer.shadowOpacity = BUTTON_SHADOW_OPACITY
        missionButton.layer.shadowOffset = CGSize.zero
        missionButton.layer.shadowRadius = BUTTON_SHADOW_RADIUS
        missionButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Diary Button
        diaryButton.setImage(diaryImg, for: .normal)
        diaryButton.layer.cornerRadius = diaryButton.frame.height / 2
        diaryButton.layer.shadowColor = UIColor.gray.cgColor
        diaryButton.layer.shadowOpacity = BUTTON_SHADOW_OPACITY
        diaryButton.layer.shadowOffset = CGSize.zero
        diaryButton.layer.shadowRadius = BUTTON_SHADOW_RADIUS
        diaryButton.translatesAutoresizingMaskIntoConstraints = false
        
        // MyPage Button
        myPageButton.setImage(myPageImg, for: .normal)
        myPageButton.layer.cornerRadius = myPageButton.frame.height / 2
        myPageButton.layer.shadowColor = UIColor.gray.cgColor
        myPageButton.layer.shadowOpacity = BUTTON_SHADOW_OPACITY
        myPageButton.layer.shadowOffset = CGSize.zero
        myPageButton.layer.shadowRadius = BUTTON_SHADOW_RADIUS
        myPageButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func finishAnimationView() {
        UIView.animate(withDuration: 0.019, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            
            self.missionButtonCenterY.constant = 0
            self.diaryButtonCenterY.constant = 0
            self.myPageButtonCenterY.constant = 0

            self.missionLabelCenterY.constant = 0
            self.diaryLabelCenterY.constant = 0
            self.myPageLabelCenterY.constant = 0

            self.missionLabelCenterX.constant = 0
            self.diaryLabelCenterX.constant = 0
            self.myPageLabelCenterX.constant = 0
            
            self.view.layoutIfNeeded() // 화면 갱신
        } completion: { (completion) in
            // 애니메이션이 끝나는 시점
            self.dismiss(animated: false, completion: nil)
        }
        delegate?.passBoolValue(isShowFloating: false)
    }
    
    @IBAction func tapMissionButton(_ sender: UIButton) {
    }
    
    @IBAction func tapDiaryButton(_ sender: UIButton) {
        let presentView = presentingViewController
        
        dismiss(animated: false) {
            let storyboard = UIStoryboard(name: "DiaryViews", bundle: nil)
            let diaryCalendarVC = storyboard.instantiateViewController(withIdentifier: "DiaryCalendarVC") as! DiaryCalendarVC
            
            diaryCalendarVC.modalPresentationStyle = .overFullScreen
            diaryCalendarVC.modalTransitionStyle = .crossDissolve
            presentView?.present(diaryCalendarVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapMyPageButton(_ sender: UIButton) {
        let presentView = presentingViewController
        
        dismiss(animated: false) {
            let storyboard = UIStoryboard(name: "MyPageView", bundle: nil)
            let myPageVC = storyboard.instantiateViewController(withIdentifier: "MyPageVC") as! MyPageVC
            
            myPageVC.modalPresentationStyle = .overFullScreen
            myPageVC.modalTransitionStyle = .crossDissolve
            presentView?.present(myPageVC, animated: true, completion: nil)
        }
    }
    
    // 유저가 화면을 터치했을 때 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        finishAnimationView()
    }

}
