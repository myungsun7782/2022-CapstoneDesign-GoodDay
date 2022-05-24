//
//  TimeSettingVM.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/22.
//

import Foundation
import Alamofire
import SwiftyJSON

// ViewModel: View와 관련된 데이터들을 모두 모아두는 곳.
class TimeSettingVM {
    var userName: String!
    var userMbti: String!
    var wakeUpTime: Date!
    var sleepTime: Date!
    var doneDelegate: SignUpDoneDelegate!
    let url = "http://ec2-15-165-147-57.ap-northeast-2.compute.amazonaws.com:8080/"
    
    func signUp() {
        let signUpUrl = url + "users/join"
        let params: Parameters = [
            "nickname": userName,
            "mbti" : userMbti,
            "wakeUpTime": TimeManager.shared.dateToHourMinuteString(date: wakeUpTime),
            "sleepTime": TimeManager.shared.dateToHourMinuteString(date: sleepTime)
        ]
        
        print("[START Request]")
        
        AF.request(signUpUrl,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type": "application/json"])
        .validate(statusCode: 200..<300)
        .responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let data):
                let uid = JSON(data)["userId"]
                
                UserDefaultsManager.shared.setUserUid(userUid: uid.rawValue as! Int)
                self.doneDelegate.signUpFinished()
            case .failure(_):
                print(response.error)
            }
        })
    }
}
