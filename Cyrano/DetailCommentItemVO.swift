//
//  DetailCommentVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 2..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class DetailCommentItemVO : Mappable{
    
    var article_id : Int?
    var user_id : Int?
    var article_type : Int?
    var reward_ink : Int?
    var title : String?
    var content : String?
    var written_time : Int?
    var parent_article_id : Int?
    var open_name : Int?
    var profile_picture : String?
    var nickname : String?
    var age : Int?
    var gender : Int?
    var level : Int?
    var is_chosen : Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        article_id <- map["article_id"]
        user_id <- map["user_id"]
        article_type <- map["article_type"]
        reward_ink <- map["reward_ink"]
        title <- map["title"]
        content <- map["content"]
        written_time <- map["written_time"]
        parent_article_id <- map["parent_article_id"]
        open_name <- map["open_name"]
        profile_picture <- map["profile_picture"]
        nickname <- map["nickname"]
        age <- map["age"]
        gender <- map["gender"]
        level <- map["level"]
        is_chosen <- map["is_chosen"]
    }
}
