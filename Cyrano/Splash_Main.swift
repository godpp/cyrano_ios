//
//  Splash_Main.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 6. 30..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit

class Splash_Main : UIViewController{
    var delayInSeconds = 2.0
    let ud = UserDefaults.standard
    
    var user_id : Int?
    

    
    override func viewDidLoad() {
        
        let accountSequence = self.ud.integer(forKey: "login_user_id")
        let diffAS = self.ud.integer(forKey: "join_user_id")
        print("어카운트시퀀스")
        print(accountSequence)
        print(diffAS)
        
        //2초뒤에 화면 전환 시켜줌
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+delayInSeconds){
            
            if accountSequence == 10000 {
                //스토리보드 객체 생성
                let main_storyboard = UIStoryboard(name: "Main", bundle: nil)
                //메인 뷰컨트롤러 접근
                guard let main = main_storyboard.instantiateViewController(withIdentifier: "Main_Tab") as? Main_Tab else {return}
                self.present(main, animated: true)
            }
            else{
                let login_storyboard = UIStoryboard(name: "Login", bundle: nil)
                guard let login = login_storyboard.instantiateViewController(withIdentifier: "Login") as? Login else {return}
                self.present(login, animated: true)
            }
        }
    }

}
