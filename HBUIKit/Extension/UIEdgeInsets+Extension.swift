//
//  UIEdgeInsets+Extension.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/2.
//

import UIKit

public extension UIEdgeInsets {
    enum Edges {
        case top
        case leading
        case bottom
        case trailing
        case all
        case horizontal
        case vertical
    }
   
    
    var width: CGFloat {
        return self.left + self.right
    }
    
    var height: CGFloat {
        return self.top + self.bottom
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    init(_ edge: Edges = .all,length: CGFloat) {
        switch edge {
        case .top:
            self.init(top: length, left: 0, bottom: 0, right: 0)
        case .leading:
            self.init(top: 0, left: length, bottom: 0, right: 0)
        case .bottom:
            self.init(top: 0, left: 0, bottom: length, right: 0)
        case .trailing:
            self.init(top: 0, left: 0, bottom: 0, right: length)
        case .all:
            self.init(horizontal: length, vertical: length)
        case .horizontal:
            self.init(horizontal: length, vertical: 0)
        case .vertical:
            self.init(horizontal: 0, vertical: length)
        }
    }
    
}
