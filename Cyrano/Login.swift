//
//  Login.swift
//  Cyrano
//
//  Created by MOON on 2017. 6. 25..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height-height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
class Login : UIViewController, UIGestureRecognizerDelegate, NetworkCallback{
    
    @IBOutlet var centerYconstraint: NSLayoutConstraint!
    @IBOutlet var loginStackView: UIStackView!
    @IBOutlet var logoImageView: UIImageView!
    
    let ud = UserDefaults.standard
    var loginVO : LoginVO?
    var check = true
    
    //통신 성공
    func networkResult(resultData: Any, code: String) {
        
        if code == "3"{
            let loginVO = resultData as! LoginVO
          
            self.loginVO = loginVO
        
            ud.setValue(self.loginVO?.user_id, forKey: "login_user_id")
            ud.setValue(self.loginVO?.ink, forKey: "ink")
        
            ud.synchronize()
            
            let main_storyboard = UIStoryboard(name: "Main", bundle: nil)
            //메인 뷰컨트롤러 접근
            guard let main = main_storyboard.instantiateViewController(withIdentifier: "Main_Tab") as? Main_Tab else {return}
            self.present(main, animated: true)
            simpleAlert(title: "성공", msg: "로그인 성공")
        }
        else if code == "1"{
            let msg = resultData as! String
            simpleAlert(title: "이멜 비번 입력 안함", msg: msg)
        }
        else if code == "2"{
            let msg = resultData as! String
            simpleAlert(title: "존재하지 않는 계정", msg: msg)
    
        }
        else if code == "4"{
            let msg = resultData as! String
            simpleAlert(title: "비밀번호 오류", msg: msg)

        }
        else{
            let msg = resultData as! String
            simpleAlert(title: "커넥션 오류", msg: msg)

        }
    }
    func networkFailed() {
        simpleAlert(title: "오류", msg: "네트워크 연결을 확인해주세요.")
    }

    //로그인버튼
    @IBAction func loginBtn(_ sender: Any) {
        
        let email  = gsno(emailTxt.text)
        let password = gsno(passTxt.text)
        let model = LoginModel(self)
        
        //입력한 이메일, 비번 삽입
        model.getLoginList(email: email, password: password)
        
     
    }
    
   //가입하기 버튼
    @IBAction func joinBtn(_ sender: Any) {
        
        guard let join_1 = storyboard?.instantiateViewController(withIdentifier: "Join_1") as? Join_1 else{
                            return
        }
        self.present(join_1, animated: true)
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTxt {
            passTxt.becomeFirstResponder()
        } else if textField == passTxt {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
        ) -> Bool {
        if(touch.view?.isDescendant(of: loginStackView))!{
            return false
        }
        return true
    }
    @objc func handleTap_mainview(_ sender: UITapGestureRecognizer?){
        self.loginStackView.becomeFirstResponder()
        self.loginStackView.resignFirstResponder()
        
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(keyboardWillShow),
            name: .UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(keyboardWillHide),
            name: .UIKeyboardWillHide,
            object: nil
        )
    }
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if check {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]
                as? NSValue)?.cgRectValue {
                centerYconstraint.constant = -150
                check = false
                logoImageView.isHidden = true
                view.layoutIfNeeded()
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]
            as? NSValue)?.cgRectValue {
            centerYconstraint.constant = 0
            check = true
            logoImageView.isHidden = false
            view.layoutIfNeeded()
        }
    }
    

    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var passTxt: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap_mainview(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)

        //textfield 밑줄 + placeholder 색지정하기 뀨
        self.emailTxt.delegate = self
        self.passTxt.delegate = self
        emailTxt.attributedPlaceholder = NSAttributedString(string: "이메일을 입력하세요.", attributes: [NSForegroundColorAttributeName:UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)])
        emailTxt.addBorderBottom(height: 1.0, color: UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0))
        
        passTxt.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력하세요.", attributes: [NSForegroundColorAttributeName:UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)])
        passTxt.addBorderBottom(height: 1.0, color: UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0))
    }

}
