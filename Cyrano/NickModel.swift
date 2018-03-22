//
//  NickModel.swift
//  Cyrano
//
//  Created by MOON on 2017. 6. 28..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NickModel : NetworkModel{
    
    func checkNickDuplication(nickname:String){
        
        let URL : String = "\(baseURL)/signup/dup"
        
        let body : [String:String] = [
            "nickname":nickname
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<MessageVO>) in
            switch response.result{
            
            case .success:
                guard let dupResult = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                if dupResult.message == "3"{
                    self.view.networkResult(resultData: "중복 없음", code: "3")
                }
                else if dupResult.message == "2"{
                    self.view.networkResult(resultData: "오류", code: "2")
                }
                else if dupResult.message == "1"{
                    self.view.networkResult(resultData: "오류", code: "1")
                }
                else if dupResult.message == "4"{
                    self.view.networkResult(resultData: "오류", code: "4")
                }
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
        }
    }
}
