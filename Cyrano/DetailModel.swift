//
//  DetailModel.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 2..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class DetailModel : NetworkModel {
    
    //요청
    func getDetailComment(article_id : Int){
        
        let URL : String = "\(baseURL)/detail_worry/comment/\(article_id)"
 
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<DetailCommentVO>) in
            
            switch response.result{
                
            case .success:
            
                print(response.result)
                
                guard let message = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                if message.message == "4"{
                    if let detailData = message.result{
                        self.view.networkResult(resultData: detailData, code: "4-1")
                    }
                    if let choices = message.choice{
                        self.view.networkResult(resultData: choices, code: "4-2")
                    }
                }
                else if message.message == "1"{
                    self.view.networkResult(resultData: "커넥팅 에러(503)", code: "1")
                }
                else if message.message == "2"{
                        self.view.networkResult(resultData: "셀렉팅 에러(503)", code: "2")
                }
                else if message.message == "3"{
                        self.view.networkResult(resultData: "등록된 질문 없음(503)", code: "3")
                }
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
    
}
