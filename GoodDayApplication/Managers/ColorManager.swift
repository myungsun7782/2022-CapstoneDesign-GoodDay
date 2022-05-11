//
//  ColorManager.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/11.
//

import UIKit

class ColorManager {
    static let shared = ColorManager()
    
    private init() {}
    
    func getThemeMain() -> UIColor {
        return UIColor(named: "ThemeMainColor")!
    }
    
    func getWhite() -> UIColor {
        return UIColor(named: "White")!
    }
    
    func getDisableColor() -> UIColor {
        return UIColor(named: "DisableColor")!
    }
    
    func getTimeTextFieldColor() -> UIColor {
        return UIColor(named: "TimeTextFieldColor")!
    }
}
