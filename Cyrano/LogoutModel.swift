//
//  LogoutModel.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 4..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
class LogoutModel : NetworkModel {
    
    func logout(){
            
        let URL : String = "\(baseURL)/logout/logout"
            
        
        Alamofire.request(URL, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
                
                (response : DataResponse<MessageVO>) in
                switch response.result{
                    
                case .success:
                    guard let logoutReult = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if logoutReult.message == "1"{
                        self.view.networkResult(resultData: 1, code: "1")
                    }
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
            }
        }
}

