//
//  UIColor+UIFont+Extension.swift
//  HB
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit

public extension UIColor {
    convenience init(r: CGFloat,  g: CGFloat, b: CGFloat, alpha: CGFloat = 1){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    convenience init(_ hex: UInt32, alpha: CGFloat = 1){
        let r = (hex & 0xFF0000) >> 16
        let g = (hex & 0x00FF00) >> 8
        let b = hex & 0x0000FF
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), alpha: alpha)
    }
    convenience init(_ hexString: String, alpha: CGFloat = 1) {
        var string: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }else if hexString.hasPrefix("0x"){
            string = String(string.suffix(string.count - 2))
        }
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }
        if string.count > 6 {
            string = String(string.prefix(6))
        }
        let scanner = Scanner(string: string)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        if string.count == 2 {
            let mask = 0xFF
            let g = Int(color) & mask
            let gray = Double(g) / 255.0
            self.init(red: gray, green: gray, blue: gray, alpha: alpha)
        } else {
            let mask = 0x0000FF
            
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            
            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
    
    static var random: UIColor {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        return UIColor.init(r: CGFloat(red), g:CGFloat(green), b: CGFloat(blue))
    }
    
}

//enum WQFontType: Int{
//    case heavy
//    case bold
//    case medium
//    case regular
//    case light
//    case exlinght
//    case num
//}
//
//extension UIFont{
//    convenience init?(type: WQFontType = .medium, size: CGFloat, isFit: Bool = true) {
//        let size = isFit ? WQ.fitW(size):size
//        var name = "PingFangSC-Regular"
//        switch type {
//        case .heavy:
//            name = "PingFangSC-Semibold"
//        case .bold:
//            name = "PingFangSC-Medium"
//        case .medium:
//            name = "PingFangSC-Regular"
//        case .regular:
//            name = "PingFangSC-Light"
//        case .light:
//            name = "PingFangTC-Thin"
//        case .exlinght:
//            name = "PingFangTC-Ultralight"
//        case .num:
//            name = "Oswald-Medium"
//        }
//        self.init(name: name, size: size)
//    }
//    
//    class func font(type: WQFontType = .medium, size: CGFloat, isFit: Bool = true) -> UIFont{
//        guard let font = UIFont(type: type, size: size, isFit: isFit) else{
//            return UIFont.systemFont(ofSize: size)
//        }
//        return font
//    }
//    
//    class func italic(type: WQFontType, size: CGFloat, italic: Double = 10) -> UIFont{
//        let font = font(type: type, size: size)
//        //设置反射 倾斜角度。
//        let matrix = CGAffineTransform.init(a: 1, b: 0, c: CGFloat(tan(italic*Double.pi/180.0)), d: 1, tx: 0, ty: 0)
//        let descriptor = UIFontDescriptor.init(name: font.fontName, matrix: matrix)
//        return UIFont(descriptor: descriptor, size: font.pointSize)
//    }
//}
