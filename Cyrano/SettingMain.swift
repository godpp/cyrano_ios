//
//  SettingMain.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 2..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
class SettingMain : UIViewController, NetworkCallback {
    
    @IBOutlet weak var profile_picture: UIImageView!
    @IBOutlet var nickname_label: UILabel!
    
    @IBOutlet var email_label: UILabel!
    @IBOutlet var ink_label: UILabel!
    
    var tensPlace : Int = 0     //십의자리
    var unitDigit : Int = 0
    
    //방아올 데이터
    var useremail : String?
    var username : String?
    var userink_ten : Int?
    var userink_unit : Int?
    var userink : Int?
    var userprofilePath : String?
    var usergender : Int?
    
    var userintroduce :String?
    var userage : Int?
    
    
    
    
    var userInfoVO : UserInfoVO?
    
     override func viewDidLoad() {
        super.viewDidLoad()

        self.setTabBar()
        
        let model = UserInfoModel(self)
        model.getUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let model = UserInfoModel(self)
        model.getUserInfo()
    }
    
    
    //탭바 설정
    func setTabBar(){
        let bar:UITabBar! = self.tabBarController?.tabBar
        bar.isTranslucent = true
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
    //통신 성공
    func networkResult(resultData: Any, code: String) {
        
        //-------------유저정보 가져오는 네트워크---------
        if code == "3"{
            userInfoVO = resultData as? UserInfoVO
            
            useremail = gsno(userInfoVO?.email)
            username = gsno(userInfoVO?.nickname)
            userink = gino(userInfoVO?.ink)
            userprofilePath = gsno(userInfoVO?.profile_picture)
            usergender = gino(userInfoVO?.gender)
            userage = gino(userInfoVO?.age)
            userintroduce = gsno(userInfoVO?.introduce)
            
            email_label.text = useremail
            nickname_label.text = username
            ink_label.text = "\(gino(userink))"
            
            //사진 이미지뷰 둥글게 만들기
            profile_picture.clipsToBounds = true
            profile_picture.layer.cornerRadius = profile_picture.frame.size.width / 2
            
            if usergender == 2{
                profile_picture.imageFromUrl(gsno(userprofilePath), defaultImgPath: "profile_man.png")
            }
            else {
                profile_picture.imageFromUrl(gsno(userprofilePath), defaultImgPath: "profile_woman.png")
            }
            
        }
        else if code == "1U" || code == "2U"{
            simpleAlert(title: "커넥팅", msg: "셀렉팅 에러")
        }
        //----------------------------------------------
        //----------------로그아웃 네트워크------------------
        if code == "1" {
            let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (_)in
                
                let splash_storyboard = UIStoryboard(name: "Splash", bundle: nil)
                //메인 뷰컨트롤러 접근
                guard let splash = splash_storyboard.instantiateViewController(withIdentifier: "Splash_Main") as? Splash_Main else {return}
                self.present(splash, animated: true, completion: nil)
                
            })
            let cancleAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(OKAction)
            alert.addAction(cancleAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    //통신 실패
    func networkFailed() {
        simpleAlert(title: "오류", msg: "네트워크 연결을 확인해주세요.")
    }
    //계정관리 버튼
    @IBAction func accountSettingBtn(_ sender: Any) {
        guard let settingAccount = storyboard?.instantiateViewController(withIdentifier : "SettingAccount") as? SettingAccount
            else{return}
        
        settingAccount.userNickname = username
        settingAccount.userIntroduce = userintroduce
        settingAccount.useremail = useremail
        settingAccount.userage = userage
        settingAccount.usergender = usergender
        settingAccount.userprofilePath = userprofilePath
        
        
        present(settingAccount, animated: true)
        
    }

    
    //잉크구매 버튼
    @IBAction func buyInk(_ sender: Any) {
        guard let buyInk = storyboard?.instantiateViewController(withIdentifier : "BuyInk") as? BuyInk
            else{return}
        buyInk.userInk = userink
         present(buyInk, animated: true)
        
    }
    //로그아웃 버튼
    @IBAction func logoutBtn(_ sender: Any) {
        let logoutmodel = LogoutModel(self)
        logoutmodel.logout()
    }
    @IBAction func noticeBtn(_ sender: Any) {
        guard let settingNotice = storyboard?.instantiateViewController(withIdentifier : "SettingNotice") as? SettingNotice
            else{return}
        
        present(settingNotice, animated: true)

        
    }

}
