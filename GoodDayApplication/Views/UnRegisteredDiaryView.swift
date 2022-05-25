//
//  UnRegisteredDiaryView.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/23.
//

import UIKit

class UnRegisteredDiaryView: UIView {
    var diaryDateString: String?
    let pointView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let gradientLayer = CAGradientLayer()
        let colors: [CGColor] = [
            ColorManager.shared.getThemeMain().cgColor,
            ColorManager.shared.getPointViewColor().cgColor]
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.cornerRadius = view.frame.width / 2
        view.layer.addSublayer(gradientLayer)
        view.layer.cornerRadius = view.frame.width / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()

        label.font = FontManager.shared.getNanumSquareB(fontSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2022. 01. 06"
        
        return label
    }()
    
    let missionLabel: UILabel = {
        let label = UILabel()
        let MISSION_DEFAULT_TEXT = "분리수거 하기"
        
        label.font = FontManager.shared.getNanumSquareR(fontSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = MISSION_DEFAULT_TEXT

        return label
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        let BUTTON_RADIUS: CGFloat = 7
        
        button.setTitle("추가하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = FontManager.shared.getNanumSquareB(fontSize: 18)
        button.titleLabel?.textColor = .white
        button.backgroundColor = ColorManager.shared.getThemeMain()
        button.layer.cornerRadius = BUTTON_RADIUS
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.addSubview(pointView)
        self.addSubview(dateLabel)
        self.addSubview(missionLabel)
        self.addSubview(registerButton)
        
        constrainCustomView()
    }
    
    func constrainCustomView() {
        NSLayoutConstraint.activate([
            pointView.topAnchor.constraint(equalTo: self.topAnchor, constant: 49),
            pointView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 45),
            dateLabel.leadingAnchor.constraint(equalTo: pointView.trailingAnchor, constant: 33),
            dateLabel.centerYAnchor.constraint(equalTo: pointView.centerYAnchor),
            
            missionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            missionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 85),
            
            registerButton.widthAnchor.constraint(equalToConstant: 300),
            registerButton.heightAnchor.constraint(equalToConstant: 60),
            registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            registerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -46)
        ])
    }

}
