//
//  DetailChoiceVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 6..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class DetailChoiceVO : Mappable{
    var article_id : Int?
    var choose_time : String?
    var choose_message : String?
    var rate : Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        article_id <- map["article_id"]
        choose_time <- map["choose_time"]
        choose_message <- map["choose_message"]
        rate <- map["rate"]
    }
}
