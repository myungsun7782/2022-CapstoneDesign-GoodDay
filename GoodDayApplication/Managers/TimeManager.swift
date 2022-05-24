//
//  TimeManager.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/11.
//

import Foundation
import SwiftDate

class TimeManager {
    static let shared = TimeManager()
    
    private init() {}
    
    func dateToHourMinString(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "hh:mm a"
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter.string(from: date)
    }
    
    func dateToHourMinuteString(date: Date) -> String {
        let formatter = DateFormatter()
    
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter.string(from: date)
    }
    
    func dateToYearMonthDayString(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: date)
    }
}
