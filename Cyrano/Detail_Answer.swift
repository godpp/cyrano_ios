//
//  Detail_Answer.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 3..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
import KMPlaceholderTextView

class Detail_Answer : UIViewController, NetworkCallback {
    
    @IBOutlet weak var title_TextField: UITextField!
    @IBOutlet weak var content_TextView: KMPlaceholderTextView!
    
    var parent_article_id : Int?

    override func viewDidLoad() {
        self.navigationItem.title = "상담작성"
        
    }
    
    // 답변글 작성완료 버튼
    @IBAction func write_answer_Btn(_ sender: Any) {
        let title = gsno(title_TextField.text)
        let content = gsno(content_TextView.text)
        let article_id = gino(parent_article_id)
        let article_type = 3
        let model = AnswerModel(self)
        model.getAnswerWrite(content: content, title: title, article_type: article_type, article_id: article_id)
        
        WriteAlert(title: "성공", msg: "답변 작성 완료")
    }
    
    // 질문보기 버튼
    @IBAction func question_look_Btn(_ sender: Any) {
    }
    
    
    //통신 성공
    func networkResult(resultData: Any, code: String) {
        if code == "6"{
        }
        else if code == "1"{
        }
    }
    
    //통신 실패
    func networkFailed() {
        simpleAlert(title: "오류", msg: "네트워크 연결을 확인해주세요.")
    }
    
    func WriteAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (UIAlertAction) in
            //self.performSegue(withIdentifier: "unwindToDetailMain", sender: self)
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
