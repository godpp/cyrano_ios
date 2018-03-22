//
//  AMessageVO.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 3..
//  Copyright © 2017년 MOON. All rights reserved.
//


import ObjectMapper

class AMessageVO : Mappable{
    
    var user : JoinVO?
    var message : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        user <- map["user"]
    }
}
