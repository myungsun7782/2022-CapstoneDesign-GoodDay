//
//  MyPageVM.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/23.
//

import Foundation
import Alamofire
import SwiftyJSON

class MbtiSettingVM {
    var mbti: String!
    let url = "http://ec2-15-165-147-57.ap-northeast-2.compute.amazonaws.com:8080/"
    
    func modifyMbti() {
        let modificationMbtiUrl = url + "users/update"
        let params: Parameters = [
            "userId": UserDefaultsManager.shared.getUserUid(),
            "mbti": "ESTJ"
        ]
        print("[START Mbti Modification]")
        
        AF.request(modificationMbtiUrl,
                   method: .patch,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type" : "application/json"])
        .validate(statusCode: 200..<300)
        .responseJSON(completionHandler: { response in
            print("status code: \(response.response?.statusCode)")
        })
    }
}
