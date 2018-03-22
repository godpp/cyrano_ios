//
//  CommentMessageVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 8..
//  Copyright © 2017년 MOON. All rights reserved.
//

import ObjectMapper

class CommentMessageVO : Mappable{
    
    var message : String?
    var data : [CommentVO]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
    }
}
