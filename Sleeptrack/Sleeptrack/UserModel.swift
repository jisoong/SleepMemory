//
//  UserModel.swift
//  Sleeptrack
//
//  Created by 강지수 on 2023/06/16.
//

import Foundation

class UserModel: Identifiable {
    public var id: Int64 = 0
    public var sleepQuality: String = ""
    public var TimeInBed_h: String = ""
    public var TimeInBed_m: String = ""

}
