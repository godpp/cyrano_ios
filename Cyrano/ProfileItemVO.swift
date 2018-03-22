//
//  ProfileItemVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 6..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileItemVO : Mappable{
    var nickname : String?
    var gender : Int?
    var profile_picture : String?
    var comment_cnt : Int?
    var level : Int?
    var introduce : String?
    
    var avg_rate : Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        nickname <- map["nickname"]
        gender <- map["gender"]
        profile_picture <- map["profile_picture"]
        comment_cnt <- map["comment_cnt"]
        level <- map["level"]
        introduce <- map["introduce"]
        
        avg_rate <- map["avg_rate"]
    }
}
