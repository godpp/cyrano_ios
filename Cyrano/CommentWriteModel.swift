//
//  CommentWriteModel.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 8..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class CommentWriteModel : NetworkModel {
    
    func getCommentWrite(comment_content : String, article_id : Int){
        
        let URL : String = "\(baseURL)/comment"
        
        let body : [String:Any] = [
            "comment_content" : comment_content ,
            "article_id" : article_id
        ]
        
        
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<CommentMessageVO>) in
            switch response.result{
                
            case .success:
                guard let message = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                if message.message == "ok"{
                    self.view.networkResult(resultData: "", code: "7")
                }
                else if message.message == "1"{
                    self.view.networkResult(resultData: "comment 빔 에러", code: "1")
                }
                else if message.message == "2"{
                    self.view.networkResult(resultData: "셀렉트 에러", code: "2")
                }
                else if message.message == "3"{
                    self.view.networkResult(resultData: "user_id 조회 실패", code: "3")
                }
                else if message.message == "4"{
                    self.view.networkResult(resultData: "잉크 업데이트 실패", code: "4")
                }
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
        }
    }
}
