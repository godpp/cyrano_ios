//
//  Main_Tab.swift
//  Cyrano
//
//  Created by 갓거 on 2017. 6. 30..
//  Copyright © 2017년 MOON. All rights reserved.
//

import Foundation
import UIKit

class Main_Tab : UITabBarController{
    override func viewDidLoad() {
        
        //TabBar tint 값 제거 및 이미지 적용
        UITabBar.appearance().barTintColor = UIColor.init(red: 27/255.0, green: 43/255.0, blue: 56/255.0, alpha: 0.0)
        var tabBar = self.tabBar
        var homeImage = UIImage(named:"tab_home_selection_last")?.withRenderingMode(.alwaysOriginal)
        var mypageImg = UIImage(named: "tab_mypage_selection_last")?.withRenderingMode(.alwaysOriginal)
        var notificationImg = UIImage(named: "tab_alram_selection_last")?.withRenderingMode(.alwaysOriginal)
        
        var settingImg = UIImage(named: "tab_setting_selection_last")?.withRenderingMode(.alwaysOriginal)
        
        (tabBar.items![0] as! UITabBarItem).selectedImage = homeImage
        (tabBar.items![1] as! UITabBarItem).selectedImage = mypageImg
        (tabBar.items![2] as! UITabBarItem).selectedImage = notificationImg
        (tabBar.items![3] as! UITabBarItem).selectedImage = settingImg
        
    }
    
}
