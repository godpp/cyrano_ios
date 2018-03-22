//
//  SecretInkMore.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 8..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit

class SecretInkMore : UIViewController{
    var use_ink : Int?
    
    var ink : Int = 300
    
    var result : Int = 0
    
    @IBOutlet weak var more_ink_Label: UILabel!
    
    override func viewDidLoad() {
        result = ink - gino(use_ink)
        more_ink_Label.text = "\(result)"
    }

    @IBAction func return_Btn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
