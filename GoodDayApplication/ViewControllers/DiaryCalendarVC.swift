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
    let REGISTERED_DIARY_IMAGE_VIEW_RADIUS: CGFloat = 8
    let REGISTERED_DIARY_BUTTON_RADIUS: CGFloat = 7
    
    // FSCalendar
    let calendarView = FSCalendar()

    // UIView
    let unRegisteredDiaryView: UnRegisteredDiaryView = UnRegisteredDiaryView()
    @IBOutlet weak var registeredDiaryView: UIView!
    @IBOutlet weak var registeredDiaryPointView: UIView!
    
    // UILabel
    @IBOutlet weak var registeredDiaryDateLabel: UILabel!
    @IBOutlet weak var registeredDiaryMissionLabel: UILabel!
    @IBOutlet weak var registeredDiaryTitleLabel: UILabel!
    @IBOutlet weak var registeredDiaryContentsLabel: UILabel!
    
    // UIImageView
    @IBOutlet weak var registeredDiaryImageView: UIImageView!
    
    // UIButton
    @IBOutlet weak var registeredDiaryButton: UIButton!
    
    // Variables
    var selectedDateStr: String!
    var registeredDiaryDateList = [String]()
    var diaryList = [Diary]()
    var isRegisteredDiary: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.reloadData()
    }
    
    func initUI() {
        // FSCalendar
        configureCalendarView()
        
        // UIView
        configureRegisteredDiaryView()
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
        // MARK: CalendarView Height: 420 -> 390
        calendarView.heightAnchor.constraint(equalToConstant: 390).isActive = true
    }
    
    private func configureUnRegisteredDiaryView() {
        unRegisteredDiaryView.alpha = 0
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
        diaryDetailVC.diaryDelegate = self
        diaryDetailVC.diaryDateStr = unRegisteredDiaryView.dateLabel.text
        diaryDetailVC.modalPresentationStyle = .overFullScreen
        diaryDetailVC.modalTransitionStyle = .crossDissolve
        present(diaryDetailVC, animated: true, completion: nil)
    }
    
    private func configureRegisteredDiaryView() {
        registeredDiaryView.alpha = 0
        // UIView
        registeredDiaryView.layer.cornerRadius = UNREGISTERED_DIARY_VIEW_RADIUS
        registeredDiaryView.layer.shadowOffset = CGSize(width: 0, height: 0)
        registeredDiaryView.layer.shadowOpacity = UNREGISTERED_DIARY_VIEW_SHADOW_OPACITY
        makePointViewGradient()
        
        // UIImageView
        registeredDiaryImageView.layer.cornerRadius = REGISTERED_DIARY_IMAGE_VIEW_RADIUS
        
        // UIButton
        registeredDiaryButton.layer.cornerRadius = REGISTERED_DIARY_BUTTON_RADIUS
        registeredDiaryButton.setTitle("더 보기", for: .normal)
        registeredDiaryButton.titleLabel?.font = FontManager.shared.getNanumSquareB(fontSize: 18)
        registeredDiaryButton.titleLabel?.textColor = ColorManager.shared.getWhite()
    }
    
    private func makePointViewGradient() {
        let gradientLayer = CAGradientLayer()
        let colors: [CGColor] = [
            ColorManager.shared.getThemeMain().cgColor,
            ColorManager.shared.getPointViewColor().cgColor]
        
        gradientLayer.frame = registeredDiaryPointView.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.cornerRadius = registeredDiaryPointView.frame.width / 2
        
        registeredDiaryPointView.layer.addSublayer(gradientLayer)
        registeredDiaryPointView.layer.cornerRadius = registeredDiaryPointView.frame.height / 2
    }
    
    private func validateIsRegisteredDiary(selectedDate: String) {
        if registeredDiaryDateList.contains(selectedDate) {
            isRegisteredDiary = true
        } else {
            isRegisteredDiary = false
        }
    }
    // MARK: 일기 등록 여부에 따라 일기장 view를 결정해주는 메소드
    private func configureDiaryView() {
        if !isRegisteredDiary {
            configureUnRegisteredDiaryView()
            unRegisteredDiaryView.isHidden = false
            registeredDiaryView.isHidden = true
            animateUnRegisteredDiaryView()
            unRegisteredDiaryView.dateLabel.text = selectedDateStr
        } else {
            configureRegisteredDiaryView()
            registeredDiaryView.isHidden = false
            unRegisteredDiaryView.isHidden = true
            animateRegisteredDiaryView()
            registeredDiaryDateLabel.text = selectedDateStr
        }
    }
    
    private func animateUnRegisteredDiaryView() {
        UIView.animate(withDuration: 0.5) {
            self.unRegisteredDiaryView.alpha = 1
        } completion: { (completion) in
        }
    }
    
    private func animateRegisteredDiaryView() {
        UIView.animate(withDuration: 0.5) {
            self.registeredDiaryView.alpha = 1
        } completion: { (completion) in
        }
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        let notificationName = Notification.Name("sendBoolData")
        let boolDic = ["isShowFloating" : false]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: boolDic)
        dismiss(animated: true, completion: nil)
    }
}

extension DiaryCalendarVC: FSCalendarDelegate, FSCalendarDataSource {
    // 캘린더에서 날짜가 선택되었을 때 호출되는 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDateStr = TimeManager.shared.dateToYearMonthDayString(date: date)
        validateIsRegisteredDiary(selectedDate: selectedDateStr)
        configureDiaryView()
//        // 선택된 날짜에 일기가 등록되어 있는 경우
//        if !isRegisteredDiary {
//            configureUnRegisteredDiaryView()
//            unRegisteredDiaryView.isHidden = false
//            registeredDiaryView.isHidden = true
//            animateUnRegisteredDiaryView()
//            unRegisteredDiaryView.dateLabel.text = selectedDateStr
//        } else { // 선택된 날짜에 일기가 등록되어 있지 않은 경우
//            configureRegisteredDiaryView()
//            registeredDiaryView.isHidden = false
//            unRegisteredDiaryView.isHidden = true
//            animateRegisteredDiaryView()
//            registeredDiaryDateLabel.text = selectedDateStr
//        }
    }
    // 캘린더에 표시되는 이벤트 갯수를 반환해주는 메소드
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateStr = TimeManager.shared.dateToYearMonthDayString(date: date)
        
        if registeredDiaryDateList.contains(dateStr) {
            return 1
        }
        return 0
    }
}

extension DiaryCalendarVC: DelegateDiaryDetailVC {
    func passDiaryData(date: String, title: String, contents: String, photoList: [UIImage]) {
        let diary = Diary(title: title, contents: contents, date: date, photoList: photoList)
        
        diaryList.append(diary)
        registeredDiaryDateList.append(date)
        registeredDiaryDateLabel.text = date
        registeredDiaryImageView.image = photoList[0]
        registeredDiaryTitleLabel.text = title
        registeredDiaryContentsLabel.text = contents
        calendarView.reloadData()
        validateIsRegisteredDiary(selectedDate: date)
        configureDiaryView()
        
    }
    
//    func passModifiedDiaryDate(date: String, title: String, contents: String, photoList: [UIImage]) {
//        
//    }
}
