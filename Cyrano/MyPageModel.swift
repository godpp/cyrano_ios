//
//  MyPageModel.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 1..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class MyPageModel : NetworkModel{
    
    //요청
    func getMyCounseling(){
        
        let URL : String = "\(baseURL)/mypage"
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<MypageVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let mypageCounselingInfo = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                
                if let IngcounselingList = mypageCounselingInfo.result1 {
                    
                    self.view.networkResult(resultData: IngcounselingList , code: "3-1")
                    
                }
                if let ComCounselingList = mypageCounselingInfo.result2 {
                    self.view.networkResult(resultData: ComCounselingList , code: "3-2")
                }
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
}


