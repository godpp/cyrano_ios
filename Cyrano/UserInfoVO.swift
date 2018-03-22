//
//  UserInfoVO.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 2..
//  Copyright © 2017년 MOON. All rights reserved.
//
import ObjectMapper

class UserInfoVO : Mappable{
    
    var user_id : Int?
    var nickname : String?
    var email : String?
    var ink : Int?
    var registration_time : String?
    var lastlogin_time : String?
    var profile_picture : String?
    var level : Int?
    var gender : Int?
    var age : Int?
    var push_token : Int?
    var introduce : String?

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        user_id <- map["user_id"]
        nickname <- map["nickname"]
        email <- map["email"]
        ink <- map["ink"]
        registration_time <- map["registration_time"]
        lastlogin_time <- map["lastlogin_time"]
        profile_picture <- map["profile_picture"]
        level <- map["level"]
        gender <- map["gender"]
        age <- map["age"]
        push_token <- map["push_token"]
        introduce <- map["introduce"]
        
    }
    
}
