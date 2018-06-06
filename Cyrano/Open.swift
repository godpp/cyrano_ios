//
//  Open.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 6. 30..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
import KMPlaceholderTextView


class Open : UIViewController, NetworkCallback {
    
    var refreshControl : UIRefreshControl!
    

    @IBOutlet weak var content_Img: UIImageView!
    @IBOutlet weak var title_Img: UIImageView!
    @IBOutlet weak var title_Text: UITextField!
    @IBOutlet weak var content_TextView: UITextView!
    @IBOutlet weak var ink_Label: UILabel!
    @IBOutlet weak var plus_ink_Btn: UIButton!
    
    var nameValue : Int = 1
    var ink_Value : String?
    var have_ink : Int?
    var real_ink : Int?
    
    
    //보류다
    override func viewDidAppear(_ animated: Bool) {
        ink_Label.text = "\(gino(real_ink))"
        print(ink_Value)
        
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
    }
    
    //글쓰기 버튼
    @IBAction func write_Btn(_ sender: Any) {
        
        let article_type = 1
        let content = gsno(content_TextView.text)
        let title = gsno(title_Text.text)
        real_ink = Int(gsno(ink_Value))
        let tag_content = ""
        let open_name = gino(nameValue)
        
        if title == nil || content == nil{
            simpleAlert(title: "에러", msg: "모두 채워주세요!")
        }
        
        if real_ink == nil{
            simpleAlert(title: "에러", msg: "잉크를 사용해주세요!")
        }
        else if gino(real_ink) >= 10 {
            let model = WriteModel(self)
            model.getWrite(article_type: article_type, content: content, title: title, reward_ink: real_ink!, tag_content: tag_content, open_name: open_name)
            
            //완료 커스텀 얼럿창
            let noldamTransitionDelegate = NoldamTrasitionDelegate(height: 272)
            transitioningDelegate = noldamTransitionDelegate
            let done_pvc = storyboard!.instantiateViewController(withIdentifier: "Done_PopupVC") as! Done_PopupVC
            done_pvc.modalPresentationStyle = .custom
            done_pvc.transitioningDelegate = noldamTransitionDelegate
            done_pvc.use_ink = gino(real_ink)
            self.present(done_pvc, animated: true)
        }
        else if gino(real_ink) < 10 && gino(real_ink) >= 0{
            simpleAlert(title: "부족", msg: "공개고민은 최소 10잉크부터 입니다!")
        }
        
    }
    
    
    
    //돌아오기 버튼
    @IBAction func return_Btn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //내 정보 공개
    @IBAction func switch_OnOff(_ sender: UISwitch) {
        if sender.isOn {
            nameValue = 1
        }
        else{
            nameValue = 2
        }
    }
    
    // 잉크 걸기
    @IBAction func plus_ink_Btn(_ sender: Any) {
        let noldamTransitionDelegate = NoldamTrasitionDelegate(height: 272)
        transitioningDelegate = noldamTransitionDelegate
        let pvc = storyboard!.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
        pvc.modalPresentationStyle = .custom
        pvc.transitioningDelegate = noldamTransitionDelegate
        pvc.ink_value = have_ink
        self.present(pvc, animated: true)
    }
    
    //통신 성공
    func networkResult(resultData: Any, code: String) {
        if code == "ok"{
            
        }
        else if code == "1"{
        }
        else if code == "2"{
        }
        else if code == "3"{
        }
        else if code == "4"{
        }
        else if code == "5"{
        }
        else if code == "6"{
        }
    }
    //통신 실패
    func networkFailed() {
        simpleAlert(title: "오류", msg: "네트워크 연결을 확인해주세요.")
    }
    
}
