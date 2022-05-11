//
//  NameVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/11.
//

import UIKit

class NameSettingVC: UIViewController {
    // Variables
    let VALID_ACTIVE_HINT = "사용 가능한 멋진 닉네임입니다."
    let VALID_DEACTIVE_HINT = "2글자에서 8글자 사이로 닉네임을 입력해주세요."
    let BUTTON_CORNER_RADIUS: CGFloat = 13
    
    // UITextField
    @IBOutlet weak var nameTextField: UITextField!
    
    // UILabel
    @IBOutlet weak var validationLabel: UILabel!
    
    // UIButton
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        // UITextField
        configureTextField()
        
        // UIButton
        configureNextButton()
    }
    
    private func configureNextButton() {
        validateNextButton()
        nextButton.layer.cornerRadius = BUTTON_CORNER_RADIUS
    }
    
    private func configureTextField() {
        nameTextField.font = UIFont(name: nameTextField.font!.fontName, size: 22)
        nameTextField.addTarget(self, action: #selector(didNameTextFieldChange(_:)), for: .editingChanged)
    }
    
    @objc private func didNameTextFieldChange(_ textField: UITextField) {
        validateNextButton()
    }
    
    private func validateNextButton() {
        // 버튼 활성화 조건
        // nameTextField가 2~8자 사이일 때 활성화
        nextButton.isEnabled = !(nameTextField.text?.isEmpty ?? true) &&
        (nameTextField.text?.count ?? 0 >= 2) &&
        (nameTextField.text?.count ?? 0 <= 8)
        validationLabel.text = nextButton.isEnabled ? VALID_ACTIVE_HINT : VALID_DEACTIVE_HINT
        
        if nextButton.isEnabled {
            // UIButton
            nextButton.backgroundColor = ColorManager.shared.getThemeMain()
            
            // UILabel
            validationLabel.textColor = ColorManager.shared.getThemeMain()
            
            // BottomBorder
            makeBottomBorder(borderColor: ColorManager.shared.getThemeMain())
        } else {
            // UIButton
            nextButton.backgroundColor = ColorManager.shared.getDisableColor()
            
            // UILabel
            // nameTextField 경우의 수
            // 1. 사용자가 이름을 입력하기 전 (Empty 상태)
            // 2. 사용자가 이름을 입력 함. (2글자 미만 or 8글자 초과)
            let validColor = nameTextField.text!.isEmpty ? ColorManager.shared.getDisableColor() : .red
            validationLabel.textColor = validColor
            
            // BottomBorder
            makeBottomBorder(borderColor: validColor)
        }
    }
    
    private func makeBottomBorder(borderColor: UIColor) {
        let border = CALayer()
        
        border.frame = CGRect(x: 0, y: nameTextField.frame.size.height - 7, width: 329, height: 1)
        border.backgroundColor = borderColor.cgColor
        nameTextField.layer.addSublayer(border)
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
//        let storyBoard = UIStoryboard(name: "InitialSettingViews", bundle: nil)
//        let mbtiSettingVC = storyBoard.instantiateViewController(withIdentifier: "MbtiSettingVC") as! MbtiSettingVC
    }
    
    // 유저가 화면을 터치했을 때 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 키보드를 내린다.
        self.view.endEditing(true)
    }
}
