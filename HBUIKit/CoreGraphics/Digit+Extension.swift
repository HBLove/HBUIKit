//
//  Digit+Extension.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/12/5.
//

#if canImport(CoreGraphics)
import CoreGraphics
#if canImport(Foundation)
import Foundation
#endif
public extension CGFloat {
    var sw: CGFloat{
        return HBApp.fitW(self)
    }
    var sh: CGFloat{
        return HBApp.fitH(self)
    }
    var screenWidth: CGFloat{
        return self * HBApp.width
    }
    var scrennHeight: CGFloat{
        return self * HBApp.height
    }
    var swMin: CGFloat{
        return HBApp.fitMin(self)
    }
    var shMin: CGFloat{
        return HBApp.fitMin(CGFloat(self), isHeight: true)
    }
    //  Absolute of CGFloat value.
    var abs: CGFloat {
        return Swift.abs(self)
    }
    
    /// Ceil of CGFloat value.
    var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    
    /// Radian value of degree input.
    var degreesToRadians: CGFloat {
        return .pi * self / 180.0
    }
    
    /// Degree value of radian input.
    var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }
    
    /// Floor of CGFloat value.
    var floor: CGFloat {
        return Foundation.floor(self)
    }
    
    /// Int.
    var int: Int {
        return Int(self)
    }

    /// Float.
    var float: Float {
        return Float(self)
    }

    ///  Double.
    var double: Double {
        return Double(self)
    }
}

public extension Int{
    var sw: CGFloat{
        return HBApp.fitW(CGFloat(self))
    }
    var sh: CGFloat{
        return HBApp.fitH(CGFloat(self))
    }
    var screenWidth: CGFloat{
        return CGFloat(self) * HBApp.width
    }
    var screenHeight: CGFloat{
        return CGFloat(self) * HBApp.height
    }
    var swMin: CGFloat{
        return HBApp.fitMin(CGFloat(self), isHeight: false)
    }
    var shMin: CGFloat{
        return HBApp.fitMin(CGFloat(self), isHeight: true)
    }
}

public extension Double{
    var sw: CGFloat{
        return HBApp.fitW(self)
    }
    var sh: CGFloat{
        return HBApp.fitH(self)
    }
    var screenWidth: CGFloat{
        return self * HBApp.width
    }
    var scrennHeight: CGFloat{
        return self * HBApp.height
    }
    var swMin: CGFloat{
        return HBApp.fitMin(self, isHeight: false)
    }
    var shMin: CGFloat{
        return HBApp.fitMin(self, isHeight: true)
    }
}

// MARK: - 字符转数字
public extension String {
    ///
    ///        "101".int -> 101
    ///
    var int: Int? {
        return Int(self)
    }
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Float value from given string.
    func float(locale: Locale = .current) -> Float? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        let f = formatter.number(from: self)?.floatValue
        return f
    }
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Double value from given string.
    func double(locale: Locale = .current) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        let double =  formatter.number(from: self)?.doubleValue
        return double
    }
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional CGFloat value from given string.
    func cgFloat(locale: Locale = .current) -> CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        let f = formatter.number(from: self) as? CGFloat
        return f
    }
}
#endif
