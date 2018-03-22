//
//  NetworkModel.swift
//  Cyrano
//
//  Created by MOON on 2017. 6. 26..
//  Copyright © 2017년 MOON. All rights reserved.
//

class NetworkModel {
    
    //뷰컨트롤러로 데이터를 전달해줄 위임자를 나타내주는 변수
    
    //callbackDelegate
    var view : NetworkCallback
    
    
    init(_ vc : NetworkCallback){
        self.view = vc
    }
    
    let baseURL = "http://13.124.155.211:3000"
}
