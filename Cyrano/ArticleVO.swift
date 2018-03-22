//
//  ArticleVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 6. 28..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class ArticleVO : Mappable{
    var result : [ArticleItemVO]?
    var message : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        result <- map["result"]
        message <- map["message"]
    }
}
