//
//  TimeSettingVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/11.
//

import UIKit

protocol DelegateTimeSettingVC: AnyObject {
    func passTimeData(wakeUpTime: Date, sleepTime: Date)
}

class TimeSettingVC: UIViewController {
    // UITextField
    @IBOutlet weak var wakeUpTimeTextField: UITextField!
    @IBOutlet weak var sleepTimeTextField: UITextField!
    
    // UIButton
    @IBOutlet weak var finishButton: UIButton!
    
    // UIDatePicker
    var wakeUpTimePicker: UIDatePicker!
    var sleepTimePicker: UIDatePicker!
    
    // Variables
    var userName: String!
    var userMbti: String!
    var wakeUpTime: Date!
    var sleepTime: Date!
    var myPageEditorMode: MyPageEditorMode = .new
    weak var delegate: DelegateTimeSettingVC?
    let userUid = UUID().uuidString
    let BUTTON_CORNER_RADIUS: CGFloat = 13
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        // UIButton
        configureFinishButton()
        validateFinishButton()
        
        // UIDatePicker
        configureTimePickers()
        
        // UITextField
        configureTimeTextFields()
        editTimeTextFields()
    }
    
    func configureTimeTextFields() {
        wakeUpTimeTextField.addTarget(self, action: #selector(didTextFieldChange(_:)), for: .editingChanged)
        sleepTimeTextField.addTarget(self, action: #selector(didTextFieldChange(_:)), for: .editingChanged)
        
        wakeUpTimeTextField.font = FontManager.shared.getNanumSquareB(fontSize: 35)
        sleepTimeTextField.font = FontManager.shared.getNanumSquareB(fontSize: 35)
        
        wakeUpTimeTextField.textColor = ColorManager.shared.getTimeTextFieldColor()
        sleepTimeTextField.textColor = ColorManager.shared.getTimeTextFieldColor()
        
        wakeUpTimeTextField.inputView = wakeUpTimePicker
        sleepTimeTextField.inputView = sleepTimePicker
    }
    
    @objc private func didTextFieldChange(_ textField: UITextField) {
        validateFinishButton()
    }
    
    private func configureTimePickers() {
        configureWakeUpTimePicker()
        configureSleepTimePicker()
    }
    
    private func configureWakeUpTimePicker() {
        wakeUpTimePicker = UIDatePicker()
        
        wakeUpTimePicker.datePickerMode = .time
        wakeUpTimePicker.preferredDatePickerStyle = .wheels
        wakeUpTimePicker.addTarget(self, action: #selector(didWakeUpTimePickerValueChange(_:)), for: .valueChanged)
    }
    
    private func configureSleepTimePicker() {
        sleepTimePicker = UIDatePicker()
        
        sleepTimePicker.datePickerMode = .time
        sleepTimePicker.preferredDatePickerStyle = .wheels
        sleepTimePicker.addTarget(self, action: #selector(didSleepTimePickerValueChange(_:)), for: .valueChanged)
    }
    
    @objc func didWakeUpTimePickerValueChange(_ timePicker: UIDatePicker) {
        wakeUpTime = wakeUpTimePicker.date
        wakeUpTimeTextField.text = TimeManager.shared.dateToHourMinString(date: wakeUpTimePicker.date)
        wakeUpTimeTextField.sendActions(for: .editingChanged)
    }
    
    @objc func didSleepTimePickerValueChange(_ timePicker: UIDatePicker){
        sleepTime = sleepTimePicker.date
        sleepTimeTextField.text = TimeManager.shared.dateToHourMinString(date: sleepTimePicker.date)
        sleepTimeTextField.sendActions(for: .editingChanged)
    }
    
    private func configureFinishButton() {
        finishButton.layer.cornerRadius = BUTTON_CORNER_RADIUS
    }
    
    private func validateFinishButton() {
        finishButton.isEnabled =
        !(wakeUpTimeTextField.text?.isEmpty ?? true) &&
        !(sleepTimeTextField.text?.isEmpty ?? true)
        
        // 버튼 활성화
        if finishButton.isEnabled {
            finishButton.titleLabel?.textColor = ColorManager.shared.getWhite()
            finishButton.backgroundColor = ColorManager.shared.getThemeMain()
        } else { // 버튼 비활성화
            finishButton.backgroundColor = ColorManager.shared.getDisableColor()
        }
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapFinishButton(_ sender: UIButton) {
        // 초기 설정인 경우
        if myPageEditorMode == .new {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            
            UserDefaultsManager.shared.saveUserInfo(userName: self.userName, userMbti: self.userMbti , userWakeUpTime: self.wakeUpTime, userSleepTime: self.sleepTime)
            
            mainVC.userName = UserDefaultsManager.shared.getUserName()
            mainVC.userUid = UserDefaultsManager.shared.getUserUid()
            mainVC.modalPresentationStyle = .overFullScreen
            mainVC.modalTransitionStyle = .crossDissolve
            present(mainVC, animated: true)
        } else { // 마이 페이지에서 수정하는 경우
            delegate?.passTimeData(wakeUpTime: wakeUpTimePicker.date, sleepTime: sleepTimePicker.date)
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func editTimeTextFields() {
        // 마이 페이지에서 기상/취침 시간을 수정하는 경우
        if myPageEditorMode == .edit {
            wakeUpTimeTextField.text = TimeManager.shared.dateToHourMinString(date: wakeUpTime!)
            sleepTimeTextField.text = TimeManager.shared.dateToHourMinString(date: sleepTime!)
            validateFinishButton()
        }
    }
    
    // 유저가 화면을 터치했을 때 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 키보드를 내린다.
        self.view.endEditing(true)
    }
}
