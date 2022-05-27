//
//  Mission.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/27.
//

import Foundation

class Mission {
    var id: Int
    var missionId: Int
    var isSuccess: Bool
    
    init(id: Int, missionId: Int, isSuccess: Bool) {
        self.id = id
        self.missionId = missionId
        self.isSuccess = false
    }
}
