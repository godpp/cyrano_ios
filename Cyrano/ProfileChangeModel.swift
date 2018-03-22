//
//  ProfileChangeModel.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 6..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class ProfileChangeModel : NetworkModel{
    
    
    
    //서버로 업로드 메소드 아직 안씀
    func ChangeMethod(uploadFile : Data?){
        
        let URL = "\(baseURL)/profile_image/profile_image"
        
        
        
        
        if uploadFile == nil{
        }
        else{
            Alamofire.upload(multipartFormData : { multipartFormData in

                //멀티파트를 이용해 데이터를 담습니다
                multipartFormData.append(uploadFile!, withName: "image", fileName: "image.jpg", mimeType: "image/png")

            },
                             
                             to: URL,
                             encodingCompletion: { encodingResult in
                                
                                switch encodingResult{
                                case .success(let upload, _, _):
                                    upload.responseData { res in
                                        switch res.result {
                                        case .success:
                                            print(JSON(res.result.value!))
                                            if let value = res.result.value {
                                                let data = JSON(value)
                                                let msg = data["message"].stringValue
                                                
                                                if msg == "1" {
                                                    DispatchQueue.main.async(execute: {
                                                        print("dispatc Queue")
                                                        self.view.networkResult(resultData: "", code: "7-1")
                                                    })
                                                    print(msg)
                                                }else if msg == "5"{
                                                    self.view.networkResult(resultData: "", code: "7-5")
                                                }else if msg == "2"{
                                                    self.view.networkResult(resultData: "", code: "7-2")
                                                }
                                                //if msg == "ok
                                                
                                                
                                        }//if let value
                                        case .failure(let err):
                                            print("upload Error : \(err)")
                                            DispatchQueue.main.async(execute: {
                                                self.view.networkFailed()
                                            })
                                        }
                                    }
                                case .failure(let err):
                                    print("network Error : \(err)")
                                    self.view.networkFailed()
                                }//switch
            }
                
            )//Alamofire.upload
            
        }
    }
}
