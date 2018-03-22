//
//  UserProfileVC.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 6..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit

class UserProfileVC : UIViewController, NetworkCallback{
    
    @IBOutlet weak var user_introduce_Label: UILabel!
    @IBOutlet weak var user_profile_Img: UIImageView!
    @IBOutlet weak var user_nickname_Label: UILabel!
    @IBOutlet weak var user_comment_count_Label: UILabel!
    
    var user_introduce : String?
    var user_profile_img : String?
    var user_nickname : String?
    var user_comment_count : Int?
    var user_gender : Int?
    
    var user_id : Int?
    
    var user_profile_List : ProfileItemVO?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let model = ProfileModel(self)
        model.getProfile(user_id: gino(user_id))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //사진 이미지뷰 둥글게 만들기
        user_profile_Img.clipsToBounds = true
        user_profile_Img.layer.cornerRadius = user_profile_Img.frame.size.width / 2
    }


    
    @IBAction func return_Btn(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "4-1"{
            user_profile_List = resultData as? ProfileItemVO

            user_introduce = gsno(user_profile_List?.introduce)
            user_profile_img = gsno(user_profile_List?.profile_picture)
            user_nickname = gsno(user_profile_List?.nickname)
            user_comment_count = gino(user_profile_List?.comment_cnt)
            user_gender = gino(user_profile_List?.gender)

            user_introduce_Label.text = user_introduce
            user_nickname_Label.text = user_nickname
            user_comment_count_Label.text = "작성답변 \(gino(user_comment_count))개"
            
            if user_gender == 1{
                user_profile_Img.imageFromUrl(gsno(user_profile_img), defaultImgPath: "profile_woman.png")
            }
            else if user_gender == 2{
                user_profile_Img.imageFromUrl(gsno(user_profile_img), defaultImgPath: "profile_man.png")
            }
            
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "에러", msg: "네트워크를 확인해주세요.")
    }
}
