//
//  NetworkCallback.swift
//  Cyrano
//
//  Created by MOON on 2017. 6. 26..
//  Copyright © 2017년 MOON. All rights reserved.
//

protocol NetworkCallback {
    
    func networkResult(resultData:Any, code:String)
    func networkFailed()
    
}
