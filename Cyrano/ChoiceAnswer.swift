//
//  ChoiceAnswer.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 4..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
import KMPlaceholderTextView
import Cosmos

class ChoiceAnswer : UIViewController, NetworkCallback{
    
    @IBOutlet weak var thanks_TextView: KMPlaceholderTextView!
    
    var article_id : Int?
    var choice_message : String?
    var rate : Int?
    
    @IBOutlet weak var rating_View: CosmosView!
    
    @IBAction func return_Btn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func write_choice_Btn(_ sender: Any) {
        choice_message = gsno(thanks_TextView.text)
        rate = Int(rating_View.rating * 2)
        
        let model = ChoiceModel(self)
        model.getChocie(article_id: gino(article_id), choose_message: gsno(choice_message), rate: gino(rate))
        
        presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "7"{
            
        }
        else if code == "1"{
        }
        else if code == "2"{
        }
        else if code == "3"{
        }
        else if code == "4"{
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "에러", msg: "네트워크 오류")
    }
    
}
