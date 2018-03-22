//
//  UserVO.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 3..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class UserVO : Mappable{
    var result : UserInfoVO?
    var message : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        result <- map["result"]
        message <- map["message"]
    }
}
