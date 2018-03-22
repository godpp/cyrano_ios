//
//  SettingAccount.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 3..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit

class SettingAccount : UIViewController, NetworkCallback {
    var userNickname : String?
    var userIntroduce: String?
    var useremail : String?
    var userage : Int?
    var usergender : Int?
    var userprofilePath : String?
    
    var rename : String? = ""
    
    @IBOutlet var nickTxt: UITextField!
    @IBOutlet var introTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var ageTxt: UITextField!
    @IBOutlet var genderTxt: UITextField!
    
    //프로필
    @IBOutlet var profileImg: UIImageView!
    
    @IBAction func profile_img_change_Btn(_ sender: Any) {
        present(picker, animated: true, completion: nil)
        
    }
    
    //갤러리를 열기위한 피커
    let picker = UIImagePickerController()

    
    
    
    override func viewDidLoad() {
        
        picker.allowsEditing = false
        picker.delegate = self
        
        
        //사진 이미지뷰 둥글게 만들기
        profileImg.clipsToBounds = true
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        
        nickTxt.text = "\(gsno(userNickname))"
        introTxt.text = "\(gsno(userIntroduce))"
        emailTxt.text = "\(gsno(useremail))"
        ageTxt.text = "\(gino(userage))"
        
        if usergender == 2 {
            genderTxt.text = "남자"
        }else{
            genderTxt.text = "여자"
        }
        
        
        if usergender == 2{
            profileImg.imageFromUrl(gsno(userprofilePath), defaultImgPath: "profile_man.png")
        }
        else {
            profileImg.imageFromUrl(gsno(userprofilePath), defaultImgPath: "profile_woman.png")
        }
        
        emailTxt.isUserInteractionEnabled = false
        ageTxt.isUserInteractionEnabled = false
        genderTxt.isUserInteractionEnabled = false
        
        emailTxt.isEnabled = false
        ageTxt.isEnabled = false
        genderTxt.isEnabled = false
        
    }
    
    //xbutton
    @IBAction func XBtn(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    @IBAction func settingBtn(_ sender: Any) {
        let inputNickname = gsno(nickTxt.text)
        let inputIntroduce = gsno(introTxt.text)
        
        let dupmodel = NickModel(self)
       
        if inputNickname == "" {
            simpleAlert(title: "사용불가", msg: "닉네임을 입력해주세요.") //_____닉네임 공백인경우
        }else if inputNickname == userNickname{
            let modiymodel = ModifyInfoModel(self)
            modiymodel.setUserInfo(nickname: inputNickname, introduce: inputIntroduce)
            //________닉네임을 변경하지 않은경우 중복확인 스킵 => 안그러면 중복으로 뜬다능 ㅠㅠ
            
        }else if rename == inputNickname {
            let modiymodel = ModifyInfoModel(self)
            modiymodel.setUserInfo(nickname: inputNickname, introduce: inputIntroduce)
            // 이미 한번 닉네임 변경후 닉네임 필드 유지할때 중복확인 스킵하기
        }else{
            dupmodel.checkNickDuplication(nickname: inputNickname)
            //________중복확인
        }

        
    }
    //통신 성공 함수 구현
    func networkResult(resultData: Any, code: String) {
        
        //let _ = navigationController?.popViewController(animated: true)
        
        //중복 확인
        if code == "3"{
            let inputNickname = gsno(nickTxt.text)
            let inputIntroduce = gsno(introTxt.text)
            let modiymodel = ModifyInfoModel(self)
            modiymodel.setUserInfo(nickname: inputNickname, introduce: inputIntroduce)
            
        }
        else if code == "2"{
            simpleAlert(title: "오류", msg: "닉네임 조회 오류")
        }
        else if code == "1"{
            simpleAlert(title: "오류", msg: "서버 연결 오류")
        }
        else if code == "4"{
            simpleAlert(title: "사용불가", msg: "이미 사용중인 닉네임 입니다.")
        }
        //회원가입
        if code == "3-1" {
            let inputNickname = gsno(nickTxt.text)
            rename = inputNickname
            simpleAlert(title: "완료", msg: "변경되었습니다.")
            
        }else if code == "1-1"{
            simpleAlert(title: "실패", msg: "커넥팅 에러")
        }else if code == "2-1" {
            simpleAlert(title: "실패", msg: "업데이트 에러")
        }
        
        if code == "7-1"{
            simpleAlert(title: "성공", msg: "프로필이 적용되었습니다.")
        }else if code == "7-2"{
            simpleAlert(title: "실패", msg: "설정에러")
        }else if code == "7-5"{
            simpleAlert(title: "실패", msg: "로그인상태 아님")
        }
        
    }
    //통신 실패 함수 구현
    func networkFailed() {
        simpleAlert(title: "오류", msg: "네트워트 연결을 확인해주세요.")
    }
    
   

}

extension SettingAccount : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //사진 선택 안하고 종료 시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //사진 선택 관련 컨트롤러
    //이미지 피커 컨트롤러에서 이미지를 선택하거나 카메라 촬영을 완료 했을 때, 호출되는 메소드입니다 만약 선택한 이미지에 대한 수정 옵션이 설정되어 있다면 이미지 수정 작업이 완료되었을 때 호출됩니다.
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            // UIImagePickerControllerEditedImage 이미지가 수정된 경우 수정된 이미지를 전달합니다
            //이미지를 이미지뷰(newImage) 에 표시
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            //UIImagePickerControllerOriginalImage 는 이미지 피커 컨트롤러에서 선택한 이미지에 대한 원본 이미지 데이터입니다. 이미지가 수정되었더라도 이 키를 이용하면 원본 데이터를 받을 수 있습니다.
            
            //이미지를 미지뷰(newImage)에 표시
            newImage = possibleImage
        } else {
            return
        }
        
        profileImg.image = newImage
        // 프로필 사진 올리기
        let model = ProfileChangeModel(self)
        if let image = profileImg.image{
            let uploadFile = UIImageJPEGRepresentation(image, 0)
            model.ChangeMethod(uploadFile: uploadFile)
        }
        else{
            model.ChangeMethod(uploadFile: nil)
        }
        
        
        dismiss(animated: true, completion: nil)
    }
}

