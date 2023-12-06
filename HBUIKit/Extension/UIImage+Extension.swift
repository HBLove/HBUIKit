//
//  UIImage+Extension.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit

public extension UIImage {
    var original: UIImage{
        if renderingMode != .alwaysOriginal {
            return self.withRenderingMode(.alwaysOriginal)
        }
        return self
    }
    
    /// 颜色生成图片
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)

        defer {
            UIGraphicsEndImageContext()
        }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }

        self.init(cgImage: aCgImage)
    }
}
