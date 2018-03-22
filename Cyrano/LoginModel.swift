//
//  LoginModel.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 6. 27..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class LoginModel : NetworkModel{
    
    //요청
    func getLoginList(email:String, password:String){
        
        let URL : String = "\(baseURL)/login/login"
        
        let body : [String:String] = [
            "email":email,
            "password":password
        ]
        
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<MessageVO>) in
            
            switch response.result{
                
            case .success:
                
          
                
                
                guard let infoFromServer = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                if infoFromServer.message == "3" {
                    
                    if let loginList = infoFromServer.result {
                        
                    self.view.networkResult(resultData: loginList , code: "3")
                        
                    }
                }
                else if infoFromServer.message == "1"{
                    self.view.networkResult(resultData: "empty Email, PW", code: "1")
                }
                else if infoFromServer.message == "2"{
                    self.view.networkResult(resultData: "No Accout", code: "2")
                }
                else if infoFromServer.message == "4"{
                    self.view.networkResult(resultData: "missing PW", code: "4")
                }
                else if infoFromServer.message == "5"{

                    self.view.networkResult(resultData: "error Connection", code: "5")
                }
            
        
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
    
    
    // 메인화면 article 불러오기
    func getMainArticleList(id : Int){
        
        let URL : String = "\(baseURL)/main/\(id)"
        
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<ArticleVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let message = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                if message.message == "4"{
                    if let articles = message.result{
                        self.view.networkResult(resultData: articles, code: "1")
                    }
                }

                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }    
}

