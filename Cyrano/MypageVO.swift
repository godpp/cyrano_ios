//
//  MypageVO.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 1..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class MypageVO : Mappable{
    var result1 : [MypageItemVO]?
    var result2 : [MypageItemVO]?
    var message : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        result1 <- map["result1"]
        result2 <- map["result2"]
        message <- map["message"]
    }
}
