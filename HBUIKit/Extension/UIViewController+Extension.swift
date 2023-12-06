//
//  UIViewController+Extension.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/12/4.
//

import UIKit

public extension UIViewController{
   @objc  var isHideNavigateion: Bool{
        return false
    }
    
   
    func getStatusBarStyle(_ isLight: Bool = true) -> UIStatusBarStyle{
        if isLight {
            return .lightContent
        }else  if #available(iOS 13.0, *) {
            return .darkContent
        }else{
            return .default
        }
    }
    
    func addChild( _ child: UIViewController, toContainerView containerView: UIView){
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeViewAndController(){
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    
    func becomeRootViewController() {
        guard let window = HBApp.firstKeyWindow else {
            return
        }
        window.rootViewController?.modalTransitionStyle = .crossDissolve
        let animation = {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = self
            UIView.setAnimationsEnabled(oldState)
        }
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: animation, completion: nil)
    }
    
}
