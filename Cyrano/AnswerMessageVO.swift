//
//  AnswerMessageVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 4..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import ObjectMapper

class AnswerMessageVO : Mappable{
    var message : String?
    var result : AnswerWriteVO?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        result <- map["result"]
    }
}
