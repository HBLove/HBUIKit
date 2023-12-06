//
//  UIFont.swift
//  HB
//
//  Created by 黄波 on 2023/12/4.
//

import Foundation
import UIKit

public extension UIFont{
    enum Style{
        case heavy
        case bold
        case medium
        case regular
        case light
        case exlinght
        case num
    }
    
    convenience init?(type: Style, size: CGFloat, isFit: Bool = true) {
        let size = isFit ? HBApp.fitW(size):size
        var name = "PingFangSC-Regular"
        switch type {
        case .heavy:
            name = "PingFangSC-Semibold"
        case .bold:
            name = "PingFangSC-Medium"
        case .medium:
            name = "PingFangSC-Regular"
        case .regular:
            name = "PingFangSC-Light"
        case .light:
            name = "PingFangTC-Thin"
        case .exlinght:
            name = "PingFangTC-Ultralight"
        case .num:
            name = "Oswald-Medium"
        }
        self.init(name: name, size: size)
    }
    
    class func font(type: Style = .medium, size: CGFloat, isFit: Bool = true) -> UIFont{
        guard let font = UIFont(type: type, size: size, isFit: isFit) else{
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    class func italic(type: Style, size: CGFloat, italic: Double = 10) -> UIFont{
        let font = font(type: type, size: size)
        //设置反射 倾斜角度。
        let matrix = CGAffineTransform.init(a: 1, b: 0, c: CGFloat(tan(italic*Double.pi/180.0)), d: 1, tx: 0, ty: 0)
        let descriptor = UIFontDescriptor.init(name: font.fontName, matrix: matrix)
        return UIFont(descriptor: descriptor, size: font.pointSize)
    }
}
