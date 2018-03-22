//
//  ProfileMessageVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 6..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileMessageVO : Mappable{
    var message : String?
    var result1 : ProfileItemVO?
    var result2 : ProfileItemVO?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        result1 <- map["result1"]
        result2 <- map["result2"]
    }
}
