//
//  SDone_PopupVC.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 7. 7..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit

class SDone_PopupVC : UIViewController{
    
    var use_ink : Int?
    
    @IBOutlet weak var ink_done_Label: UILabel!
    
    @IBAction func accept_Btn(_ sender: Any) {
        guard let main_tab = self.storyboard?.instantiateViewController(withIdentifier: "Main_Tab") as? Main_Tab else{
            return
        }
        self.present(main_tab, animated: true)
    }
    
    override func viewDidLoad() {
        ink_done_Label.text = "\(gino(use_ink)) 잉크가 차감되었어요."
    }
}
