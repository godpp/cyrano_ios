//
//  File.swift
//  Cyrano
//
//  Created by MOON on 2017. 6. 27..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
class Join_3: UIViewController, NetworkCallback{
    
    @IBOutlet var nickTxt: UITextField!
    

    @IBOutlet var possibleImg: UIImageView!
    @IBOutlet var impossibleImg: UIImageView!
    
    let ud = UserDefaults.standard
    var userData : AMessageVO?
    
    //정보 받아올 변수
    var email : String?
    var password : String?
    var age : Int?
    var gender : Int?
    
    //flag  정보 저장 위한 변수
    var canuse : Int = 0
    
    //중복확인받은 닉네임 받아오기 위한 변수
    var nickname_join : String?
    
    override func viewDidLoad() {
        //textfield 밑줄 + placeholder 색지정하기 뀨
        self.nickTxt.delegate = self
        nickTxt.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSForegroundColorAttributeName:UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)])
        possibleImg.isHidden = true
        impossibleImg.isHidden = true
    }
    
    //통신 성공 함수 구현
    func networkResult(resultData: Any, code: String) {
        
        //중복 확인
        if code == "3"{
            possibleImg.isHidden = false
            impossibleImg.isHidden = true
            canuse = 1
        }
        else if code == "2"{
            simpleAlert(title: "", msg: "로그인 실패")

        }
        else if code == "1"{
            simpleAlert(title: "", msg: "로그인 실패")
        }
        else if code == "4"{

            impossibleImg.isHidden = false
            possibleImg.isHidden = true
        }
    }
    //통신 실패 함수 구현
    func networkFailed() {
        simpleAlert(title: "오류", msg: "네트워트 연결을 확인해주세요.")
    }
    
    //중복확인 버튼
    @IBAction func dupBtn(_ sender: Any) {
       
        
        let nickname = gsno(nickTxt.text)
        let model = NickModel(self)
        nickname_join = nickname
        if nickname == ""{
          simpleAlert(title: "경고", msg: "닉네임을 입력해주세요")
        }else{
            model.checkNickDuplication(nickname: nickname)
        
        }
        
    }
    //이전 버튼 
    @IBAction func backBtn_2(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func JoinBtn(_ sender: Any) {

        if canuse == 1 {
            //화면 전환
            guard let join_last = storyboard?.instantiateViewController(withIdentifier : "Join_last") as? Join_last
                else{return}
            
            join_last.email = email
            join_last.password = password
            join_last.gender = gender
            join_last.age = age
            join_last.nickname = nickname_join
            
            present(join_last, animated: true)
            
            
        } else {
            simpleAlert(title: "경고", msg: "닉네임중복 확인을 완료해주세요.")
        }
        
    }
    
    
    
    
}
