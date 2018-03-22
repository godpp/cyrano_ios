//
//  SettingNotice.swift
//  Cyrano
//
//  Created by MOON on 2017. 7. 4..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit
class SettingNotice : UIViewController{


    @IBAction func XBtn(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
}
