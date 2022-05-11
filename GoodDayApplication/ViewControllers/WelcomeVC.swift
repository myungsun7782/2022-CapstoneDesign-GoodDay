//
//  WelcomeVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/11.
//

import UIKit

class WelcomeVC: UIViewController {
    // UIButton
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "InitialSettingViews", bundle: nil)
        let nameVC = storyboard.instantiateViewController(withIdentifier: "NameSettingVC")
        
        nameVC.modalPresentationStyle = .overFullScreen
        nameVC.modalTransitionStyle = .crossDissolve
        self.present(nameVC, animated: true, completion: nil)
    }
}
