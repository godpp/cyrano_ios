//
//  CommentVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 8..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class CommentVO : Mappable{
    var nickname : String?
    var comment_content : String?
    var comment_written_time : Int?
    var profile_picture : String?
    var level : Int?
    var gender : Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        nickname <- map["nickname"]
        comment_content <- map["comment_content"]
        comment_written_time <- map["comment_written_time"]
        profile_picture <- map["profile_picture"]
        level <- map["level"]
        gender <- map["gender"]
    }
}
