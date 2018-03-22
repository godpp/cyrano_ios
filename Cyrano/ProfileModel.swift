//
//  ProfileModel.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 6..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ProfileModel : NetworkModel {
    
    //요청
    func getProfile(user_id : Int){
        
        let URL : String = "\(baseURL)/profile/\(user_id)"
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<ProfileMessageVO>) in
            
            
            switch response.result{
                
            case .success:
                
                print(response.result)
                
                guard let message = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                if message.message == "4"{
                    if let profile = message.result1{
                        self.view.networkResult(resultData: profile, code: "4-1")
                    }
                    if let avgRate = message.result2{
                        self.view.networkResult(resultData: avgRate, code: "4-2")
                    }
                }
                else if message.message == "1"{
                        self.view.networkResult(resultData: "커넥팅 에러", code: "1")
                }
                else if message.message == "2"{
                        self.view.networkResult(resultData: "셀렉팅 유저 정보 에러", code: "2")
                }
                else if message.message == "3"{
                        self.view.networkResult(resultData: "셀렉팅 별점 평균 에러", code: "3")
                }
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
    
}
