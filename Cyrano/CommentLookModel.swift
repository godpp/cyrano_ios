//
//  CommentLookModel.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 8..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class CommentLookModel : NetworkModel {
    
    //요청
    func getComment(article_id : Int){
        
        let URL : String = "\(baseURL)/comment/\(article_id)"
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<CommentMessageVO>) in
            
            
            switch response.result{
                
            case .success:
                
                print(response.result)
                
                guard let message = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                if message.message == "3"{
                    if let commentdata = message.data{
                        self.view.networkResult(resultData: commentdata, code: "3")
                    }
                }
                else if message.message == "1"{
                    self.view.networkResult(resultData: "커넥팅 에러", code: "1")
                }
                else if message.message == "2"{
                    self.view.networkResult(resultData: "셀렉팅 에러", code: "2")
                }
        
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
    
}
