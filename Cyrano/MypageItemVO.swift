//
//  MypageItemVO.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 1..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class MypageItemVO : Mappable{
    
    var is_chosen : Int?
    var article_id : Int?
    var user_id : Int?
    var article_type : Int?
    var reward_ink : Int?
    var title : String?
    var content : String?
    var written_time : Int?
    var parent_article_id : Int?
    var open_name : Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        is_chosen <- map["is_chosen"]
        article_id <- map["article_id"]
        user_id <- map["user_id"]
        article_type <- map["article_type"]
        reward_ink <- map["reward_ink"]
        title <- map["title"]
        content <- map["content"]
        written_time <- map["written_time"]
        parent_article_id <- map["parent_article_id"]
        open_name <- map["open_name"]
        
    }
}
