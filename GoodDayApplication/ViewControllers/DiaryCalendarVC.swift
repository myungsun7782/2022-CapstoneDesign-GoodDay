//
//  DiaryCalendarVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/23.
//

/**
 //    @IBOutlet weak var diaryButton: UIButton!
 
 //    @IBAction func tapDiaryButton(_ sender: UIButton) {
 //        let storyboard = UIStoryboard(name: "DiaryViews", bundle: nil)
 //        let diaryDetailVC = storyboard.instantiateViewController(withIdentifier: "DiaryDetailVC") as! DiaryDetailVC
 //
 //        diaryDetailVC.modalPresentationStyle = .overFullScreen
 //        diaryDetailVC.modalTransitionStyle = .crossDissolve
 //        present(diaryDetailVC, animated: true, completion: nil)
 //    }
 
 **/
import UIKit
import FSCalendar

enum DiaryEditorMode {
    case new
    case edit
}

class DiaryCalendarVC: UIViewController {
    // Constant
    let CALENDAR_HEADER_DATE_FORMAT = "MMMM  yyyy"
    let CALENDAR_HEADER_MINIMUM_DISSOLVED_ALPHA: CGFloat = 0
    let CALENDAR_BORDER_RADIUS: CGFloat = 1
    let UNREGISTERED_DIARY_VIEW_RADIUS: CGFloat = 38
    let UNREGISTERED_DIARY_VIEW_SHADOW_OPACITY: Float = 0.25
    
    // FSCalendar
    let calendarView = FSCalendar()

    // UIView
    let unRegisteredDiaryView: UnRegisteredDiaryView = UnRegisteredDiaryView()
    
    // Variables
    var selectedDateStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        // FSCalendar
        configureCalendarView()
    }
    
    private func configureCalendarView() {
        calendarView.appearance.headerTitleColor = .black
        calendarView.appearance.weekdayTextColor = ColorManager.shared.getCalendarWeekDayTextColor()
        calendarView.appearance.weekdayFont = FontManager.shared.getNanumSquareB(fontSize: 14)
        calendarView.appearance.titlePlaceholderColor = ColorManager.shared.getCalendarTitlePlaceHolderColor()
        calendarView.appearance.headerDateFormat = CALENDAR_HEADER_DATE_FORMAT
        calendarView.locale = Locale(identifier: "en_US")
        calendarView.appearance.headerMinimumDissolvedAlpha = CALENDAR_HEADER_MINIMUM_DISSOLVED_ALPHA
        calendarView.appearance.titleFont = FontManager.shared.getNanumSquareR(fontSize: 15)
        calendarView.appearance.headerTitleFont = FontManager.shared.getNanumSquareR(fontSize: 15)
        calendarView.appearance.titleTodayColor = ColorManager.shared.getThemeMain()
        calendarView.appearance.todayColor = ColorManager.shared.getWhite()
        calendarView.appearance.selectionColor = ColorManager.shared.getThemeMain()
        calendarView.appearance.eventDefaultColor = ColorManager.shared.getThemeMain()
        calendarView.appearance.eventSelectionColor = ColorManager.shared.getWhite()
        calendarView.appearance.borderRadius = CALENDAR_BORDER_RADIUS
        calendarView.appearance.eventOffset = .init(x: -0.3, y: -11)
        calendarView.appearance.headerTitleOffset = .init(x: -75, y: -10)
        calendarView.appearance.headerTitleAlignment = .left
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        constrainCalendarView()
    }
    
    private func constrainCalendarView() {
        calendarView.dataSource = self
        calendarView.delegate = self
        view.addSubview(calendarView)
        calendarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        calendarView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80).isActive = true
        calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        calendarView.widthAnchor.constraint(equalToConstant: 390).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 420).isActive = true
    }
    
    private func configureUnRegisteredDiaryView() {
        unRegisteredDiaryView.backgroundColor = ColorManager.shared.getWhite()
        unRegisteredDiaryView.layer.cornerRadius = UNREGISTERED_DIARY_VIEW_RADIUS
        unRegisteredDiaryView.layer.shadowOpacity = UNREGISTERED_DIARY_VIEW_SHADOW_OPACITY
        unRegisteredDiaryView.translatesAutoresizingMaskIntoConstraints = false
        unRegisteredDiaryView.registerButton.addTarget(self, action: #selector(tapRegisterButton), for: .touchUpInside)
        view.addSubview(unRegisteredDiaryView)
        constrainUnRegisteredDiaryView()
    }
    
    private func constrainUnRegisteredDiaryView() {
        NSLayoutConstraint.activate([
            unRegisteredDiaryView.widthAnchor.constraint(equalToConstant: 390),
            unRegisteredDiaryView.heightAnchor.constraint(equalToConstant: 250),
            unRegisteredDiaryView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            unRegisteredDiaryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            unRegisteredDiaryView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
    
    @objc private func tapRegisterButton() {
        let storyboard = UIStoryboard(name: "DiaryViews", bundle: nil)
        let diaryDetailVC = storyboard.instantiateViewController(withIdentifier: "DiaryDetailVC") as! DiaryDetailVC

        diaryDetailVC.diaryEditorMode = .new
        diaryDetailVC.diaryDateStr = unRegisteredDiaryView.dateLabel.text
        diaryDetailVC.modalPresentationStyle = .overFullScreen
        diaryDetailVC.modalTransitionStyle = .crossDissolve
        present(diaryDetailVC, animated: true, completion: nil)
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        let notificationName = Notification.Name("sendBoolData")
        let boolDic = ["isShowFloating" : false]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: boolDic)
        dismiss(animated: true, completion: nil)
    }
}

extension DiaryCalendarVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDateStr = TimeManager.shared.dateToYearMonthDayString(date: date)
        configureUnRegisteredDiaryView()
        unRegisteredDiaryView.dateLabel.text = selectedDateStr
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }
    
    
}
