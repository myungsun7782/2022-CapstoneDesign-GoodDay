//
//  DetailImageVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/24.
//

import UIKit
import Hero
class DetailImageVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var testImageView: UIImageView!
    
    var detailImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
//        self.hero.isEnabled = true
//        self.testImageView.hero.id = "imageView"
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapContainerView)))
        
        UIView.transition(with: testImageView,
                          duration: 2,
                          options: .transitionCrossDissolve,
                          animations: {
            self.testImageView.image = self.detailImage
        })
    }
    

    @objc private func tapContainerView(_: UIView) {
        self.dismiss(animated: true)
    }


}
