//
//  SPopupVC.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 7..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit

class SPopupVC : UIViewController{
    
    @IBOutlet weak var ink_Label: UILabel!
    @IBOutlet weak var ink_Text: UITextField!
    
    var ink_value : String?
    var value : Int?
    
    @IBAction func acceptBtn(_ sender: UIButton) {
        ink_value = ink_Text.text
        
            if let presenter = presentingViewController as? Secret{
                presenter.ink_Value = gsno(ink_value)
                print(ink_value)
            }
            dismiss(animated: true, completion: nil)
    }
    
    //int_Label 실시간 변화를 위한 메소드
    func isValid(){
        ink_Label.text = ink_Text.text
    }
    
    override func viewDidLoad() {
        ink_Text.addTarget(self, action: #selector(isValid), for: .editingChanged)
    }
}
