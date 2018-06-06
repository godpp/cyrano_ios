//
//  Join_1.swift
//  Cyrano
//
//  Created by MOON on 2017. 6. 28..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
class Join_1 : UIViewController{

    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var passTxt: UITextField!
    @IBOutlet var conPassTxt: UITextField!
    @IBOutlet var centerYconstraint: NSLayoutConstraint!
    @IBOutlet var logoImageView: UIImageView!
    
    var emaildata : String?
    var passworddata : String?
    var passworddata_c : String?
    var check = true
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        self.emailTxt.delegate = self
        self.passTxt.delegate = self
        self.conPassTxt.delegate = self
        
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTxt {
            passTxt.becomeFirstResponder()
        } else if textField == passTxt {
            conPassTxt.becomeFirstResponder()
        } else if textField == conPassTxt{
            textField.resignFirstResponder()
        }
        return true
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
        ) -> Bool {
        if(touch.view?.isDescendant(of: emailTxt))!{
            return false
        }
        return true
    }
    @objc func handleTap_mainview(_ sender: UITapGestureRecognizer?){
        self.emailTxt.becomeFirstResponder()
        self.emailTxt.resignFirstResponder()
        
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
                centerYconstraint.constant = 0
                check = false
                logoImageView.isHidden = true
                view.layoutIfNeeded()
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]
            as? NSValue)?.cgRectValue {
            centerYconstraint.constant = 131.5
            check = true
            logoImageView.isHidden = false
            view.layoutIfNeeded()
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        emaildata = gsno(emailTxt.text)
        passworddata = gsno(passTxt.text)
        passworddata_c = gsno(conPassTxt.text)
        
        if emaildata == "" || passworddata == "" || passworddata_c == ""{
            
            //공백이 있는경우
            simpleAlert(title: "경고", msg: "모든정보를 입력해주세요.")
        
        }else{
            if passworddata_c != passworddata{
            //비밀번호와 비밀번호 확인이 다른경우
                simpleAlert(title: "확인", msg: "비밀번호와 비밀번호 확인이 일치하지 않습니다.")
                
            }else{
                guard let join_2 = storyboard?.instantiateViewController(withIdentifier : "Join_2") as? Join_2
                    else{return}
                
                join_2.emaildata = emaildata!
                join_2.passworddata = passworddata!
                present(join_2, animated: true)

                
            }
        
            
            
        }
        
    }
    
}
