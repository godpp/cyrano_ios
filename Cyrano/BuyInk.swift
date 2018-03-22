//
//  BuyInk.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 3..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
class BuyInk :UIViewController {
    
    @IBOutlet var InkLabel: UILabel!
    
    
    var userInk : Int?
    
    
    override func viewDidLoad() {
        InkLabel.text = "\(gino(userInk))"
    }
    @IBAction func XBtn(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
 
}
