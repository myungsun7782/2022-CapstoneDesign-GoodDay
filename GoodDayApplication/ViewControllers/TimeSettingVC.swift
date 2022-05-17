//
//  TimeSettingVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/11.
//

import UIKit

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
    var mbti: String!
    var wakeUpTime: Date!
    var sleepTime: Date!
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
    }
    
    // 유저가 화면을 터치했을 때 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 키보드를 내린다.
        self.view.endEditing(true)
    }
}
