//
//  JoinModel.swift
//  Cyrano
//
//  Created by MOON on 2017. 6. 29..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


class JoinModel : NetworkModel {

    func createMember(nickname:String, email:String, password:String, age:Int, gender:Int){
        
        let URL : String = "\(baseURL)/signup/up"
        
        let body = [
            "nickname":nickname,
            "email":email,
            "password":password,
            "age":age,
            "gender":gender
        ] as [String : Any]
    
        Alamofire.request(URL, method: .post, parameters: body, encoding:JSONEncoding.default, headers:nil).responseObject{
            (response : DataResponse<AMessageVO>) in
            
            print(response.result)
            switch response.result{
            
            case .success:
                guard let createResult = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                if createResult.message == "2"{
                    if let userData = createResult.user{
                        self.view.networkResult(resultData: userData, code: "5")
                    }
                }else if createResult.message == "3"{

                    self.view.networkResult(resultData: "오류", code: "6")
                }
            case .failure(let err):
                print(err)
                self.view.networkFailed()
                
            
            }
        
        }
    
    }



}
