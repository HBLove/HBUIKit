//
//  CACornerMask+Extension.swift
//  HB
//
//  Created by 黄波 on 2023/11/2.
//

import UIKit
public extension CACornerMask {
    static var topLeft: CACornerMask {
        return layerMinXMinYCorner
    }
    static var topRight: CACornerMask {
        return layerMaxXMinYCorner
    }
    static var bottomLeft: CACornerMask {
        return layerMinXMaxYCorner
    }
    static var bottomRight: CACornerMask {
        return layerMaxXMaxYCorner
    }
}
