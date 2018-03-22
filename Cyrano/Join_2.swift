//
//  Join_2.swift
//  Cyrano
//
//  Created by MOON on 2017. 6. 26..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
class Join_2 :UIViewController{
    var gender : Int = -1
    var tensPlace : Int = 2     //십의자리
    var unitDigit : Int = 0     //일의자리
    var age : Int = 20
    
    //전화면에서 받아올 데이터
    var emaildata : String?
    var passworddata : String?
    
    
    var man_grey : UIImage = UIImage(named:"man_grey")!
    var man : UIImage = UIImage(named:"man")!
    var woman : UIImage = UIImage(named:"woman")!
    var woman_grey : UIImage = UIImage(named:"woman_grey")!
    @IBOutlet var manBtn: UIButton!
    @IBOutlet var womanBtn: UIButton!
   
    @IBOutlet var tensPlaceImg: UIImageView!
    @IBOutlet var unitPlaceImg: UIImageView!

    //남자 버튼 눌렸을때
    
    @IBAction func manBtnListener(_ sender: Any) {
        if gender == 1 {
            womanBtn.setImage(woman_grey, for: .normal)
        }
        manBtn.setImage(man, for: .normal)
        gender = 2
    }
    //여자 버튼 눌렸을때 
    @IBAction func womanBtnListener(_ sender: Any) {
        if gender == 2 {
            manBtn.setImage(man_grey, for: .normal)
        }
        womanBtn.setImage(woman, for: .normal)
        gender = 1
        
    }
    //나이 상승버튼
    @IBAction func ageIncreaseListener(_ sender: Any) {
        if unitDigit == 9 && tensPlace == 9{
            
        } else if unitDigit == 9 {
            tensPlace += 1
            unitDigit = 0
            
            tensPlaceImg.image = UIImage(named: "age_"+String(tensPlace)+"0")!
            unitPlaceImg.image = UIImage(named: "age_0")!
        } else{
            unitDigit += 1
            unitPlaceImg.image = UIImage(named: "age_"+String(unitDigit))!
        }
        age = tensPlace*10 + unitDigit
    }
    //나이 감소버튼
    @IBAction func ageDecreaseListener(_ sender: Any) {
        if unitDigit == 0 && tensPlace == 0  {
        } else if unitDigit == 0 {
            tensPlace -= 1
            unitDigit = 9
            tensPlaceImg.image = UIImage(named: "age_"+String(tensPlace)+"0")!
            unitPlaceImg.image = UIImage(named: "age_9")!
        } else{
            unitDigit -= 1
            unitPlaceImg.image = UIImage(named: "age_"+String(unitDigit))!
        }
        age = tensPlace*10 + unitDigit
    }
    
    //다음단계 눌렀을때
    @IBAction func nextBtn_2(_ sender: Any) {
        if gender == -1 {
            simpleAlert(title: "경고", msg: "성별을 선택해 주세요.")
        }else{
            guard let join_3 = storyboard?.instantiateViewController(withIdentifier : "Join_3") as? Join_3
                else{return}
            
            join_3.email = emaildata!
            join_3.password = passworddata!
            join_3.gender = gender
            join_3.age = age
            present(join_3, animated: true)

        }
    }
    
    //이전단계 눌렀을때
    @IBAction func backBtn(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    
    
    
} 
