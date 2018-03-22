//
//  ModifyInfoModel.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 3..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ModifyInfoModel : NetworkModel{
    
    //요청
    func setUserInfo(nickname : String, introduce : String){
        
        
        let URL : String = "\(baseURL)/setup/modify"
        let body : [String:String] = [
            "nickname" : nickname ,
            "introduce" : introduce
        ]
        
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<MessageVO>) in
            
            switch response.result{
                
                
            case .success:
               
                guard let ModifyResult = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                if ModifyResult.message == "3"{
                    self.view.networkResult(resultData: 1, code: "3-1")
                }
                else if ModifyResult.message == "1"{
                    self.view.networkResult(resultData: 0, code: "1-1")
                }
                else if ModifyResult.message == "2"{
                    self.view.networkResult(resultData: 0, code: "2-1")
                }

                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
    
}
