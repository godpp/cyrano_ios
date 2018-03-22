//
//  MentorProfileVC.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 6..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class MentorProfileVC : UIViewController, NetworkCallback{
    
    @IBOutlet weak var mentor_profile_Img: UIImageView!
    @IBOutlet weak var mentor_nickname_Label: UILabel!
    @IBOutlet weak var mentor_avg_rate_cosmos: CosmosView!
    
    @IBOutlet weak var mentor_introduce_Label: UILabel!
    @IBOutlet weak var mentor_comment_count_Label: UILabel!
    
    var mentor_introduce : String?
    var mentor_profile_img : String?
    var mentor_nickname : String?
    var mentor_comment_count : Int?
    var user_gender : Int?
    var mentor_rate : Int?
    
    var user_id : Int?
    
    var mentor_profile_List : ProfileItemVO?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mentor_avg_rate_cosmos.settings.updateOnTouch = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let model = ProfileModel(self)
        model.getProfile(user_id: gino(user_id))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //사진 이미지뷰 둥글게 만들기
        mentor_profile_Img.clipsToBounds = true
        mentor_profile_Img.layer.cornerRadius = mentor_profile_Img.frame.size.width / 2
    }
    
    
    
    @IBAction func return_Btn(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "4-1"{
            mentor_profile_List = resultData as? ProfileItemVO
            
            mentor_introduce = gsno(mentor_profile_List?.introduce)
            mentor_profile_img = gsno(mentor_profile_List?.profile_picture)
            mentor_nickname = gsno(mentor_profile_List?.nickname)
            mentor_comment_count = gino(mentor_profile_List?.comment_cnt)
            user_gender = gino(mentor_profile_List?.gender)
            mentor_rate = gino(mentor_profile_List?.avg_rate)
            
            mentor_introduce_Label.text = mentor_introduce
            mentor_nickname_Label.text = mentor_nickname
            mentor_comment_count_Label.text = "작성답변 \(gino(mentor_comment_count))개"
            //mentor_avg_rate_cosmos.rating = Double(Double((mentor_profile_List?.avg_rate)!)/2)
            
            if user_gender == 1{
                mentor_profile_Img.imageFromUrl(gsno(mentor_profile_img), defaultImgPath: "profile_woman.png")
            }
            else if user_gender == 2{
                mentor_profile_Img.imageFromUrl(gsno(mentor_profile_img), defaultImgPath: "profile_man.png")
            }
            
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "에러", msg: "네트워크를 확인해주세요.")
    }

}
