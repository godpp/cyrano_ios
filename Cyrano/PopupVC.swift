//
//  PopupVC.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 1..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit

class PopupVC : UIViewController{
    
    @IBOutlet weak var ink_Label: UILabel!
    @IBOutlet weak var ink_Text: UITextField!
    
    var ink_value : Int?
    
    
    @IBAction func acceptBtn(_ sender: UIButton) {
        
        if let presenter = presentingViewController as? Open{
            presenter.ink_Value = gsno(ink_Text.text)
        }
        print(ink_Text.text)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        ink_Label.text = "\(gino(ink_value))"
    }
}
