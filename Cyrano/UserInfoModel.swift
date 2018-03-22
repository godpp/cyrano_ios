//
//  UserInfoModel.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 2..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class UserInfoModel : NetworkModel{
    
    
    //요청
    func getUserInfo(){
        
        let URL : String = "\(baseURL)/user"
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<UserVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let userInfo = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                if userInfo.message == "3"{
                    if let userInfoList = userInfo.result {
                    
                        self.view.networkResult(resultData: userInfoList , code: "3")
                    
                    }
                }else if userInfo.message == "1"{
                    if let userInfoList = userInfo.result {
                        
                        self.view.networkResult(resultData: userInfoList , code: "1U")
                        
                    }
                
                }else if userInfo.message == "2"{
                    if let userInfoList = userInfo.result {
                        
                        self.view.networkResult(resultData: userInfoList , code: "2U")
                        
                    }
                }
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
}


