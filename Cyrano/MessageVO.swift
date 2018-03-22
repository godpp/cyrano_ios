//
//  LoginListVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 6. 27..
//  Copyright © 2017년 MOON. All rights reserved.
//

import ObjectMapper

class MessageVO : Mappable{
    
    var message : String?
    var result : LoginVO?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        result <- map["result"]
    }
}
