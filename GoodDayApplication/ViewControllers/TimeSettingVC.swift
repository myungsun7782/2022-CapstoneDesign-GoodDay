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

protocol SignUpDoneDelegate {
    func signUpFinished()
}

class TimeSettingVC: UIViewController {
    // Constant
    let BUTTON_CORNER_RADIUS: CGFloat = 13

    // UITextField
    @IBOutlet weak var wakeUpTimeTextField: UITextField!
    @IBOutlet weak var sleepTimeTextField: UITextField!
    
    // UIButton
    @IBOutlet weak var finishButton: UIButton!
    
    // UIDatePicker
    var wakeUpTimePicker: UIDatePicker!
    var sleepTimePicker: UIDatePicker!
    
    // Variables
    var myPageEditorMode: MyPageEditorMode = .new
    weak var delegate: DelegateTimeSettingVC?
    let userUid = UUID().uuidString
    var timeSettingVM = TimeSettingVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        timeSettingVM.doneDelegate = self
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
        timeSettingVM.wakeUpTime = wakeUpTimePicker.date
        wakeUpTimeTextField.text = TimeManager.shared.dateToHourMinString(date: wakeUpTimePicker.date)
        wakeUpTimeTextField.sendActions(for: .editingChanged)
    }
    
    @objc func didSleepTimePickerValueChange(_ timePicker: UIDatePicker){
        timeSettingVM.sleepTime = sleepTimePicker.date
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
        
        // ?????? ?????????
        if finishButton.isEnabled {
            finishButton.titleLabel?.textColor = ColorManager.shared.getWhite()
            finishButton.backgroundColor = ColorManager.shared.getThemeMain()
        } else { // ?????? ????????????
            finishButton.backgroundColor = ColorManager.shared.getDisableColor()
        }
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapFinishButton(_ sender: UIButton) {
        // ?????? ????????? ??????
        if myPageEditorMode == .new {
            timeSettingVM.signUp()
        } else { // ?????? ??????????????? ???????????? ??????
            delegate?.passTimeData(wakeUpTime: wakeUpTimePicker.date, sleepTime: sleepTimePicker.date)
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func editTimeTextFields() {
        // ?????? ??????????????? ??????/?????? ????????? ???????????? ??????
        if myPageEditorMode == .edit {
            wakeUpTimeTextField.text = TimeManager.shared.dateToHourMinString(date: timeSettingVM.wakeUpTime!)
            sleepTimeTextField.text = TimeManager.shared.dateToHourMinString(date: timeSettingVM.sleepTime!)
            validateFinishButton()
        }
    }
    
    // ????????? ????????? ???????????? ??? ???????????? ?????????
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // ???????????? ?????????.
        self.view.endEditing(true)
    }
}

// Delegate
extension TimeSettingVC: SignUpDoneDelegate {
    func signUpFinished() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC

        UserDefaultsManager.shared.saveUserInfo(userName: timeSettingVM.userName, userMbti: timeSettingVM.userMbti , userWakeUpTime: timeSettingVM.wakeUpTime, userSleepTime: timeSettingVM.sleepTime)

        mainVC.userName = UserDefaultsManager.shared.getUserName()
        mainVC.modalPresentationStyle = .overFullScreen
        mainVC.modalTransitionStyle = .crossDissolve
        present(mainVC, animated: true)
    }
}
