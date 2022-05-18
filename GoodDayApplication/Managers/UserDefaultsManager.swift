//
//  UserDefaultsManager.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/11.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    private let IS_INITIALIZED = "isInitialized"
    private let USER_NAME = "userName"
    private let USER_UID = "userUid"
    private let BEGIN_DAY = "beginDay"
    private let MBTI = "mbti"
    private let WAKE_UP_TIME = "wakeUpTime"
    private let SLEEP_TIME = "sleepTime"
    
    
    func getIsInitialized() -> Bool {
        return UserDefaults.standard.bool(forKey: IS_INITIALIZED)
    }
    
    func setIsInitialized() {
        UserDefaults.standard.set(true, forKey: IS_INITIALIZED)
    }
    
    func setUserName(name: String) {
        UserDefaults.standard.set(name, forKey: USER_NAME)
    }
    
    func getUserName() -> String {
        if let userName = UserDefaults.standard.string(forKey: USER_NAME){
            return userName
        }else {
            return ""
        }
    }
    
    func getUserUid() -> String {
        return UserDefaults.standard.string(forKey: USER_UID)!
    }
    
    func setUserUid() {
        let userUid = UUID().uuidString
        UserDefaults.standard.set(userUid, forKey: USER_UID)
    }
    
    func getBeginDay() -> Date {
        return UserDefaults.standard.object(forKey: BEGIN_DAY) as! Date
    }
    
    func setBeginDay() {
        let beginDay = Date()
        UserDefaults.standard.set(beginDay, forKey: BEGIN_DAY)
    }
    
    func getWakeUpTime() -> Date {
        return UserDefaults.standard.object(forKey: WAKE_UP_TIME) as! Date
    }
    
    func setWakeUpTime(wakeUpTime: Date) {
        UserDefaults.standard.set(wakeUpTime, forKey: WAKE_UP_TIME)
    }
    
    func getSleepTime() -> Date {
        return UserDefaults.standard.object(forKey: SLEEP_TIME) as! Date
    }
    
    func setSleepTime(sleepTime: Date) {
        UserDefaults.standard.set(sleepTime,forKey: SLEEP_TIME)
    }
    
    func getMbti() -> String {
        return UserDefaults.standard.string(forKey: MBTI)!
    }
    
    func setMbti(mbti: String) {
        UserDefaults.standard.set(mbti, forKey: MBTI)
    }
    
    func saveUserInfo(userName: String, userMbti: String ,userWakeUpTime: Date, userSleepTime: Date){
//        setIsInitialized()
        setUserUid()
        setBeginDay()
        setUserName(name: userName)
        setMbti(mbti: userMbti)
        setWakeUpTime(wakeUpTime: userWakeUpTime)
        setSleepTime(sleepTime: userSleepTime)
    }
}
