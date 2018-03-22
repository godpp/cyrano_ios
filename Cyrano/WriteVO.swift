//
//  WriteVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 6. 30..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class WriteVO : Mappable{
    var article_type : Int?
    var content : String?
    var reward_ink : Int?
    var tag_content : String?
    var open_name : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        article_type <- map["article_type"]
        content <- map["content"]
        reward_ink <- map["reward_ink"]
        tag_content <- map["tag_content"]
        open_name <- map["open_name"]
    }
}
