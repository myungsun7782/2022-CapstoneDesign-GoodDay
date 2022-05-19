//
//  MyPageVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/19.
//

import UIKit

class MyPageVC: UIViewController {
    // UIView
    @IBOutlet weak var myPageSubView: UIView!
    @IBOutlet weak var lineView: UIView!
    
    // UILabel
    @IBOutlet weak var mbtiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wakeUpTimeLabel: UILabel!
    @IBOutlet weak var sleepTimeLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var mbtiEditLabel: UILabel!
    @IBOutlet weak var wakeUpTimeEditLabel: UILabel!
    @IBOutlet weak var sleepTimeEditLabel: UILabel!
    
    // UIButton
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var mbtiEditButton: UIButton!
    @IBOutlet weak var timeEditButton: UIButton!
    
    // UIImageView
    @IBOutlet weak var myPageImageView: UIImageView!
    
    // UIStackView
    @IBOutlet weak var mbtiStackView: UIStackView!
    @IBOutlet weak var wakeUpTimeStackView: UIStackView!
    @IBOutlet weak var sleepTimeStackView: UIStackView!
    
    // Variables
    let editImage = UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .bold))
    let rightChevronImg = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold))
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
