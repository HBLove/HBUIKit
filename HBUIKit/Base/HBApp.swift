//
//  SwiftHBApp.swift
//  HB
//
//  Created by 黄波 on 2023/11/22.
//

import UIKit

public struct HBApp {
    public static let width  = UIScreen.main.bounds.width
    public static let height = UIScreen.main.bounds.height
    
    public static var firstKeyWindow: UIWindow?{
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }
    public static var isIPhoneX: Bool{
        return tabBottom > 0
    }
    //导航，标签， 转态栏
    public static var statusHeight: CGFloat{
        return firstKeyWindow?.safeAreaInsets.top ?? 20
    }
    
    public static var navHeight: CGFloat {
        return statusHeight + navBarHeight
    }
    
    public static var navLargeHeight: CGFloat{
        return statusHeight + navBarLargeHeight
    }
    
    public static let navBarHeight: CGFloat = 44
    
    public static let navBarLargeHeight: CGFloat = 96
    
    public static var tabHeight: CGFloat{
        return tabBottom + tabBarHeight
    }
    
    public static var tabBottom: CGFloat{
        return firstKeyWindow?.safeAreaInsets.bottom ?? 0
    }
    public static let tabBarHeight: CGFloat = 49
    //宽高比
    public static let widthR = width/375
    public static let heightR = height/812
}

extension HBApp {
    //打开设置 ，网页
    public static func openUrl(_ path: String? = nil){
        let path = path ??  UIApplication.openSettingsURLString
        guard let url = URL(string: path) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    //适配
    public static func fitW(_ w: CGFloat) -> CGFloat{
        return CGFloat(ceilf(Float(w * widthR)))
    }
    public static func fitH(_ h: CGFloat) -> CGFloat{
        return CGFloat(ceilf(Float(h * heightR)))
    }
    
    public static func fitMin(_ h: CGFloat, isHeight: Bool = false) -> CGFloat{
        return  isHeight ? min(h, fitH(h)) : min(h, fitW(h))
    }
    public static func fitMax(_ h: CGFloat, isHeight: Bool = false) -> CGFloat{
        return  isHeight ? max(h, fitH(h)) : max(h, fitW(h))
    }
    
    public static func fitBottom(_ y: CGFloat) -> CGFloat{
        return max(y, tabBottom)
    }
    
   
    
//    static func adjustsScrollViewInset(_ controller: UIViewController?, _ view: UIScrollView){
//        view.contentInsetAdjustmentBehavior = .never
//    }
    
    
    public static func pLog(_ items: Any, isError: Bool? = nil, from function: StaticString = #function){
        debugPrint(isError == nil ?"❤️：":(isError == true ? "❌：":"✅："),
                    items,
                    " \(function)",
                   separator: "\n~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
        
    }
    
    
    public static func exit(){
        if let firstKeyWindow {
            UIView.animate(withDuration: 0.25, delay: 0.0, animations: {
                firstKeyWindow.alpha = 0
                firstKeyWindow.frame = CGRect(x: 0, y: firstKeyWindow.bounds.size.height, width: 0, height: 0)
            }) { _ in
                Darwin.exit(0)
            }
        }else{
            Darwin.exit(0)
        }
    }
}
