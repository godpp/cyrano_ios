//
//  ArticleItemVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 6. 28..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class ArticleItemVO : Mappable{
    
    var article_id : Int?
    var user_id : Int?
    var article_type : Int?
    var reward_ink : Int?
    var title : String?
    var content : String?
    var written_time : Int?
    var parent_article_id : Int?
    var open_name : Int?
    var like_count : Int?
    var comment_count : Int?
    var nickname : String?
    var profile_picture : String?
    var age : Int?
    var gender : Int?
    var tag_id : Int?
    var tag_content : String?
    var tag_registration_time : String?
    var is_like : Int?
    var answer_count : Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        like_count <- map["like_count"]
        comment_count <- map["comment_count"]
        article_id <- map["article_id"]
        user_id <- map["user_id"]
        article_type <- map["article_type"]
        reward_ink <- map["reward_ink"]
        title <- map["title"]
        content <- map["content"]
        written_time <- map["written_time"]
        parent_article_id <- map["parent_article_id"]
        open_name <- map["open_name"]
        nickname <- map["nickname"]
        profile_picture <- map["profile_picture"]
        age <- map["age"]
        gender <- map["gender"]
        tag_id <- map["tag_id"]
        tag_content <- map["tag_content"]
        tag_registration_time <- map["tag_registration_time"]
        is_like <- map["is_like"]
        answer_count <- map["answer_count"]
    }
}
