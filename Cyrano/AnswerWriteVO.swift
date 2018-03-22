//
//  AnswerWriteVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 4..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class AnswerWriteVO : Mappable{
    
    var content : String?
    var title : String?
    var article_type : Int?
    var article_id : Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        content <- map["content"]
        title <- map["title"]
        article_type <- map["article_type"]
        article_id <- map["article_id"]
    }
}
