//
//  DetailCommentVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 2..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class DetailCommentVO : Mappable{
    var result : [DetailCommentItemVO]?
    var message : String?
    var choice : [DetailChoiceVO]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        result <- map["result"]
        message <- map["message"]
        choice <- map["choice"]
    }
}
