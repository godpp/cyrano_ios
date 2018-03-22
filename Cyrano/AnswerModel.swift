//
//  CommentModel.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 4..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class AnswerModel : NetworkModel{
    //요청
    func getAnswerWrite(content:String, title:String, article_type:Int, article_id:Int){
        
        let URL : String = "\(baseURL)/answer"
        
        let body : [String:Any] = [
            "content":content,
            "title":title,
            "article_type":article_type,
            "article_id":article_id
        ]
        
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<AnswerMessageVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let message = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                if message.message == "6"{
                    if let results = message.result{
                        self.view.networkResult(resultData: results, code: "6")
                    }
                }
                else if message.message == "1"{
                        self.view.networkResult(resultData: "커넥팅 에러", code: "1")
                }
                else if message.message == "2"{
                    self.view.networkResult(resultData: "유저아이디 = 상담글 아이디", code: "2")
                }
                else if message.message == "3"{
                    self.view.networkResult(resultData: "중복 답변글", code: "3")
                }
                else if message.message == "4"{
                    self.view.networkResult(resultData: "insert 에러", code: "4")
                }
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
}
