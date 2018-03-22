//
//  Write.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 6. 29..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit


class Write:UIViewController {
    
    var ink_value : Int?
    let ud = UserDefaults.standard
    
    @IBOutlet weak var userInk_Label: UILabel!
    
    // ink 띄우는 부분
    override func viewDidAppear(_ animated: Bool) {
        let ink = ud.value(forKey: "ink")
        ink_value = ink as? Int
        
        userInk_Label.text = "\(gino(ink_value))"
    }


    //메인으로 돌아가는 버튼
    @IBAction func unwide_main_Btn(_ sender: Any) {}
    
    @IBAction func Open_Btn(_ sender: Any) {
        guard let open = storyboard?.instantiateViewController(withIdentifier: "Open") as? Open else{
            return
        }
        open.have_ink = ink_value
        self.present(open, animated: true)
    }
    @IBAction func Secret_Btn(_ sender: Any) {
        guard let secret = storyboard?.instantiateViewController(withIdentifier: "Secret") as? Secret else{
            return
        }
        secret.have_ink = ink_value
        self.present(secret, animated: true)
    }
    
}
