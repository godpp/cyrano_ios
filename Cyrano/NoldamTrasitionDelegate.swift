//
//  NoldamTrasitionDelegate.swift
//  PresentationControllerTest
//
//  Created by  noldam on 2016. 10. 25..
//  Copyright © 2016년 Noldam. All rights reserved.
//

import UIKit

class NoldamTrasitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var height: CGFloat = 470
    
    override init() {
        super.init()
    }
    
    init(height: CGFloat) {
        super.init()
        self.height = height
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController!, source: UIViewController) -> UIPresentationController? {
        let presentationController = NoldamPresentationController(presentedViewController:presented, presenting:presenting, height: height)
        
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = NoldamAnimatedTransitioning()
        animationController.isPresentation = true
        return animationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = NoldamAnimatedTransitioning()
        animationController.isPresentation = false
        return animationController
    }
}
