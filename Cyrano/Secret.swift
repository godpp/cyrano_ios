//
//  Secret.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 6. 30..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
import KMPlaceholderTextView

class Secret : UIViewController, NetworkCallback{
    
    @IBOutlet weak var content_TextView: KMPlaceholderTextView!
    @IBOutlet weak var title_Text: UITextField!
    @IBOutlet weak var ink_Label: UILabel!
    
    var nameValue : Int = 1
    var ink_Value : String?
    var have_ink : Int?
    
    
    //보류다
    override func viewDidAppear(_ animated: Bool) {
        ink_Label.text = ink_Value
        
    }
    
    override func viewDidLoad() {
        
        //title_Text.addTarget(self, action: #selector(titleChbegin), for: .editingDidBegin)
        //title_Text.addTarget(self, action: #selector(titleChend), for: .editingDidEnd)
        
        
        
        //        if ink_Label.text != "00"{
        //            plus_ink_Btn.imageView?.image = #imageLiteral(resourceName: "writepage_icon_ink_pink")
        //        }
        //        else {
        //            plus_ink_Btn.imageView?.image = #imageLiteral(resourceName: "writepage_icon_ink_grey")
        //        }
        
    }
    
    //    //텍스트 필드 커스텀 4가지
    //    func titleChbegin(){
    //        if (title_Text.isEditing) {
    //            title_Img.image = #imageLiteral(resourceName: "writepage_titlebox_pink")
    //        }
    //    }
    //    func titleChend(){
    //        if (title_Text.endEditing(true)){
    //            title_Img.image = #imageLiteral(resourceName: "writepage_titlebox")
    //        }
    //    }
    
    
    
    //해쉬태그 추가 버튼
    @IBAction func hashtag_Btn(_ sender: Any) {
        guard let hashtag = storyboard?.instantiateViewController(withIdentifier: "Hashtag") as? Hashtag else{
            return
        }
        self.present(hashtag, animated: true)
        
    }
    
    //글쓰기 버튼
    @IBAction func write_Btn(_ sender: Any) {
        
        let article_type = 2
        let content = gsno(content_TextView.text)
        let title = gsno(title_Text.text)
        let reward_ink = Int(gsno(ink_Value))
        let tag_content = ""
        let open_name = gino(nameValue)
        
        if reward_ink == nil {
            simpleAlert(title: "잉크 에러", msg: "잉크를 사용해주세요!")
        }
        else if gino(reward_ink) >= 300{
            
            let model = WriteModel(self)
            model.getWrite(article_type: article_type, content: content, title: title, reward_ink: reward_ink!, tag_content: tag_content, open_name: open_name)
            
            //완료 커스텀 얼럿창
            let noldamTransitionDelegate = NoldamTrasitionDelegate(height: 272)
            transitioningDelegate = noldamTransitionDelegate
            let sdone_pvc = storyboard!.instantiateViewController(withIdentifier: "SDone_PopupVC") as! SDone_PopupVC
            sdone_pvc.modalPresentationStyle = .custom
            sdone_pvc.transitioningDelegate = noldamTransitionDelegate
            sdone_pvc.use_ink = gino(reward_ink)
            present(sdone_pvc, animated: true)
        }
        else if gino(reward_ink) < 300 && gino(reward_ink) >= 0 {
            let more_ink = storyboard!.instantiateViewController(withIdentifier: "SecretInkMore") as! SecretInkMore
            more_ink.use_ink = gino(reward_ink)
            present(more_ink, animated: true)
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
        let pvc = storyboard!.instantiateViewController(withIdentifier: "SPopupVC") as! SPopupVC
        pvc.modalPresentationStyle = .custom
        pvc.transitioningDelegate = noldamTransitionDelegate
        
        present(pvc, animated: true)
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
