//
//  WriteModel.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 1..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class WriteModel : NetworkModel{
    
    //요청
    func getWrite(article_type : Int, content : String, title : String, reward_ink : Int, tag_content : String, open_name : Int){
        
        let URL : String = "\(baseURL)/main/write"
        
        let body : [String:Any] = [
            "article_type":article_type,
            "content":content,
            "title":title,
            "reward_ink":reward_ink,
            "tag_content":tag_content,
            "open_name":open_name
        ]
        
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<MessageVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let message = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                if message.message == "ok" {

                    self.view.networkResult(resultData: "" , code: "ok")
                }
                else if message.message == "1"{

                    self.view.networkResult(resultData: "", code: "1")
                }
                else if message.message == "2"{

                    self.view.networkResult(resultData: "", code: "2")
                }
                else if message.message == "3"{

                    self.view.networkResult(resultData: "", code: "3")
                }
                else if message.message == "4"{
                    self.view.networkResult(resultData: "", code: "4")
                }
                else if message.message == "5"{
                    self.view.networkResult(resultData: "", code: "5")
                }
                else if message.message == "6"{
                    self.view.networkResult(resultData: "", code: "6")
                }
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }

}
