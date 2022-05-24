//
//  MbtiSettingVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/11.
//

import UIKit

enum MbtiPosition: Int {
    case first = 0
    case second = 1
    case third = 2
    case fourth = 3
}

protocol DelegateMbtiSettingVC: AnyObject {
    func passMbtiData(mbti: String)
}

class MbtiSettingVC: UIViewController {
    // Constant
    let FONT_SIZE: CGFloat = 28
    let MBTI_LIST_SIZE = 2
    let MBTI_LIST = [
        ["E", "I"],
        ["S", "N"],
        ["T", "F"],
        ["J", "P"]
    ]
    let BUTTON_CORNER_RADIUS: CGFloat = 13
    let BLACK_CG_COLOR: CGColor = UIColor.black.cgColor
    
    // UIButton
    @IBOutlet weak var nextButton: UIButton!
    
    // UITextField
    @IBOutlet weak var firstMbtiTextField: UITextField!
    @IBOutlet weak var secondMbtiTextField: UITextField!
    @IBOutlet weak var thirdMbtiTextField: UITextField!
    @IBOutlet weak var fourthMbtiTextField: UITextField!
    
    // UIPickerView
    var firstMbtiPicker: UIPickerView?
    var secondMbtiPicker: UIPickerView?
    var thirdMbtiPicker: UIPickerView?
    var fourthMbtiPicker: UIPickerView?
    
    // UIBarButtonItem
    var finishButton: UIBarButtonItem!
    
    // UIToolbar
    var toolbar: UIToolbar!
    
    // Variables
    var userName: String!
    var mbtiPosition: MbtiPosition?
    var mbtiTextFieldList: [UITextField] = []
    weak var delegate: DelegateMbtiSettingVC?
    var myPageEditorMode: MyPageEditorMode = .new
    var mbtiSettingVM = MbtiSettingVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        // UIButton
        configureNextButton()
        
        // UITextField
        configureMbtiTextFields()
        editMbtiTextFields()
        
        // UIPickerView
        configureMbtiPicker()
        
        // UIBarButton
        configureFinishButton()
        
        // UIToolBar
        configureToolbar()
    }
    
    private func configureNextButton() {
        validateNextButton()
        nextButton.layer.cornerRadius = BUTTON_CORNER_RADIUS
    }
    
    private func validateNextButton() {
        nextButton.isEnabled =
        !(firstMbtiTextField.text?.isEmpty ?? true) &&
        !(secondMbtiTextField.text?.isEmpty ?? true) &&
        !(thirdMbtiTextField.text?.isEmpty ?? true) &&
        !(fourthMbtiTextField.text?.isEmpty ?? true)
        
        // 버튼이 활성화 되어 있는 경우
        if nextButton.isEnabled {
            nextButton.titleLabel?.textColor = ColorManager.shared.getWhite()
            nextButton.backgroundColor = ColorManager.shared.getThemeMain()
        }else { // 버튼 비활성화
            nextButton.backgroundColor = ColorManager.shared.getDisableColor()
        }
    }
    
    private func configureMbtiTextFields() {
        // MbtiTextFields event 등록
        firstMbtiTextField.addTarget(self, action: #selector(beginFirstTextField(_:)), for: .editingDidBegin)
        secondMbtiTextField.addTarget(self, action: #selector(beginSecondTextField(_:)), for: .editingDidBegin)
        thirdMbtiTextField.addTarget(self, action: #selector(beginThirdTextField(_:)), for: .editingDidBegin)
        fourthMbtiTextField.addTarget(self, action: #selector(beginFourthTextField(_:)), for: .editingDidBegin)
        
        // MbtiTextFields font
        firstMbtiTextField.font = UIFont(name: firstMbtiTextField.font!.fontName, size: FONT_SIZE)
        secondMbtiTextField.font = UIFont(name: secondMbtiTextField.font!.fontName, size: FONT_SIZE)
        thirdMbtiTextField.font = UIFont(name: thirdMbtiTextField.font!.fontName, size: FONT_SIZE)
        fourthMbtiTextField.font = UIFont(name: fourthMbtiTextField.font!.fontName, size: FONT_SIZE)
        
        // UITextField 아래 쪽에 border 추가
        makeBottomBorders()
    
        // Add MbtiTextFields to List
        mbtiTextFieldList.append(firstMbtiTextField)
        mbtiTextFieldList.append(secondMbtiTextField)
        mbtiTextFieldList.append(thirdMbtiTextField)
        mbtiTextFieldList.append(fourthMbtiTextField)
    }
    
    @objc private func beginFirstTextField(_ textField: UITextField) {
        let isEmpty = textField.text?.isEmpty
        if isEmpty! {
            textField.text = "E"
        } else {
            textField.text = "E"
        }
        mbtiPosition = .first
        firstMbtiTextField.inputView = firstMbtiPicker
        firstMbtiTextField.inputAccessoryView = toolbar
        validateNextButton()
    }
    
    @objc private func beginSecondTextField(_ textField: UITextField) {
        let isEmpty = textField.text?.isEmpty
        if isEmpty! {
            textField.text = "S"
        } else {
            textField.text = "S"
        }
        mbtiPosition = .second
        secondMbtiTextField.inputView = secondMbtiPicker
        secondMbtiTextField.inputAccessoryView = toolbar
        validateNextButton()
    }
    
    @objc private func beginThirdTextField(_ textField: UITextField) {
        let isEmpty = textField.text?.isEmpty
        if isEmpty! {
            textField.text = "T"
        } else {
            textField.text = "T"
        }
        mbtiPosition = .third
        thirdMbtiTextField.inputView = thirdMbtiPicker
        thirdMbtiTextField.inputAccessoryView = toolbar
        validateNextButton()
    }
    
    @objc private func beginFourthTextField(_ textField: UITextField){
        let isEmpty = textField.text?.isEmpty
        if isEmpty! {
            textField.text = "J"
        } else {
            textField.text = "J"
        }
        mbtiPosition = .fourth
        fourthMbtiTextField.inputView = fourthMbtiPicker
        fourthMbtiTextField.inputAccessoryView = toolbar
        validateNextButton()
    }
    
    private func makeBottomBorders() {
        let firstBorder = CALayer()
        let secondBorder = CALayer()
        let thirdBorder = CALayer()
        let fourthBorder = CALayer()
        
        firstBorder.frame = CGRect(x: 0, y: firstMbtiTextField.frame.height - 5, width: firstMbtiTextField.frame.width, height: 1)
        secondBorder.frame = CGRect(x: 0, y: secondMbtiTextField.frame.height - 5 , width: secondMbtiTextField.frame.width, height: 1)
        thirdBorder.frame = CGRect(x: 0, y: thirdMbtiTextField.frame.height - 5, width: thirdMbtiTextField.frame.width, height: 1)
        fourthBorder.frame = CGRect(x: 0, y: fourthMbtiTextField.frame.height - 5, width: fourthMbtiTextField.frame.width, height: 1)
        
        firstBorder.backgroundColor = BLACK_CG_COLOR
        secondBorder.backgroundColor = BLACK_CG_COLOR
        thirdBorder.backgroundColor = BLACK_CG_COLOR
        fourthBorder.backgroundColor = BLACK_CG_COLOR
        
        firstMbtiTextField.layer.addSublayer(firstBorder)
        secondMbtiTextField.layer.addSublayer(secondBorder)
        thirdMbtiTextField.layer.addSublayer(thirdBorder)
        fourthMbtiTextField.layer.addSublayer(fourthBorder)
    }
    
    private func configureMbtiPicker() {
        // UIPickerView 생성
        firstMbtiPicker = UIPickerView()
        secondMbtiPicker = UIPickerView()
        thirdMbtiPicker = UIPickerView()
        fourthMbtiPicker = UIPickerView()
        
        // UIPickerView background color
        firstMbtiPicker?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        secondMbtiPicker?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        thirdMbtiPicker?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        fourthMbtiPicker?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        // UIPickerView delegate, datasource 지정
        firstMbtiPicker?.delegate = self
        firstMbtiPicker?.dataSource = self
        
        secondMbtiPicker?.delegate = self
        secondMbtiPicker?.dataSource = self
        
        thirdMbtiPicker?.delegate = self
        thirdMbtiPicker?.dataSource = self
        
        fourthMbtiPicker?.delegate = self
        fourthMbtiPicker?.dataSource = self
    }
    
    private func configureFinishButton() {
        finishButton = UIBarButtonItem()
        finishButton.title = "완료"
        finishButton.target = self
        finishButton.action = #selector(closeMbtiPicker)
    }
    
    @objc func closeMbtiPicker() {
        validateNextButton()
        self.view.endEditing(true)
    }
    
    private func configureToolbar() {
        toolbar = UIToolbar()
        toolbar.backgroundColor = .white
        toolbar.tintColor = ColorManager.shared.getThemeMain()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        
        let flextSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flextSpace, self.finishButton], animated: true)
    }
    
    private func combineMbti() -> String {
        return firstMbtiTextField.text! + secondMbtiTextField.text! + thirdMbtiTextField.text! + fourthMbtiTextField.text!
    }
    
    
    private func editMbtiTextFields() {
        // 사용자가 MBTI를 수정하는 경우
        if let mbti = mbtiSettingVM.mbti {
            if myPageEditorMode == .edit {
                firstMbtiTextField.text = String(mbti[mbti.startIndex])
                secondMbtiTextField.text = String(mbti[mbti.index(mbti.startIndex, offsetBy: 1)])
                thirdMbtiTextField.text = String(mbti[mbti.index(mbti.startIndex, offsetBy: 2)])
                fourthMbtiTextField.text = String(mbti[mbti.index(mbti.startIndex, offsetBy: 3)])
                // TODO: 버튼 text "완료"로 바꾸기
                validateNextButton()
            }
        }
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        // 초기 설정의 경우
        if myPageEditorMode == .new {
            let storyboard = UIStoryboard(name: "InitialSettingViews", bundle: nil)
            let timeSettingVC = storyboard.instantiateViewController(withIdentifier: "TimeSettingVC") as! TimeSettingVC
            
            timeSettingVC.timeSettingVM.userName = userName
            timeSettingVC.timeSettingVM.userMbti = combineMbti()
            timeSettingVC.modalTransitionStyle = .crossDissolve
            timeSettingVC.modalPresentationStyle = .overFullScreen
            present(timeSettingVC, animated: true, completion: nil)
        } else { // 마이 페이지에서 수정하는 경우
            mbtiSettingVM.mbti = combineMbti()
            mbtiSettingVM.modifyMbti()
//            delegate?.passMbtiData(mbti: mbtiSettingVM.mbti)
//            dismiss(animated: true, completion: nil)
        }
    }
    
    // 유저가 화면을 터치했을 때 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 키보드를 내린다.
        self.view.endEditing(true)
    }
}

extension MbtiSettingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    // 한 뷰에 pickerview가 몇 개 담겨져 있는지 반환 (만약 여러 개의 pickerview가 존재하면 가로로 정렬)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // pickerView의 선택지 갯수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MBTI_LIST_SIZE
    }
    
    // pickerView에 들어가는 선택지의 값들을 설정
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var pickerTitle: String?
        switch mbtiPosition {
        case .first:
            pickerTitle = (row == 0) ? (MBTI_LIST[row][row] + " (외향형)") : (MBTI_LIST[row-1][row] + " (내향형)")
        case .second:
            pickerTitle = (row == 0) ? (MBTI_LIST[row+1][row] + " (감각형)") : (MBTI_LIST[row][row] + " (직관형)")
        case .third:
            pickerTitle = (row == 0) ? (MBTI_LIST[row+2][row] + " (사고형)") : (MBTI_LIST[row+1][row] + " (감정형)")
        case .fourth:
            pickerTitle = (row == 0) ? (MBTI_LIST[row+3][row] + " (판단형)") : (MBTI_LIST[row+2][row] + " (인식형)")
        default:
            break
        }
        return pickerTitle
    }
    
    // pickerView에서 선택지 값이 선택된 후에 호출
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mbtiTextFieldList[mbtiPosition!.rawValue].text = MBTI_LIST[mbtiPosition!.rawValue][row]
    }
}
