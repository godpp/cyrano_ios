//
//  Join_last.swift
//  Cyrano
//
//  Created by MOON on 2017. 6. 28..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
class Join_last : UIViewController, NetworkCallback{
    
    var email : String?
    var password : String?
    var gender : Int?
    var age : Int?
    var nickname : String?
    
    let ud = UserDefaults.standard
    
    var userData : AMessageVO?
    
    func networkResult(resultData: Any, code: String) {
        //회원가입
        if code == "5" {
            let userData = resultData as? AMessageVO
            self.userData = userData
            
            
            
        }else if code == "6"{
            simpleAlert(title: "실패", msg: "이메일 중복")
        }else {
        }
        
    }
    func networkFailed() {
        simpleAlert(title: "오류", msg: "네트워트 연결을 확인해주세요.")
    }
    
    @IBAction func startBtn(_ sender: Any) {
        
        let model_join = JoinModel(self)
        model_join.createMember(nickname: gsno(nickname), email: gsno(email), password: gsno(password), age: gino(age), gender: gino(gender))
        
        ud.setValue(self.userData?.user?.user_id, forKey: "join_user_id")
        
        ud.synchronize()
        
        let main_storyboard = UIStoryboard(name: "Main", bundle: nil)
        //메인 뷰컨트롤러 접근
        guard let main = main_storyboard.instantiateViewController(withIdentifier: "Main_Tab") as? Main_Tab else {return}
        present(main, animated: true)
    }
    
}
