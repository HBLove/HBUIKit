//
//  Spacer.swift
//  HB
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit

open class Spacer: UIView {
    public let spacing: CGFloat
    public var axis: NSLayoutConstraint.Axis? {
        didSet {
            translatesAutoresizingMaskIntoConstraints = false
            switch axis {
            case .horizontal:
                widthAnchor.constraint(equalToConstant: spacing).isActive = true
            case .vertical:
                heightAnchor.constraint(equalToConstant: spacing).isActive = true
            default:
                break
            }
        }
    }
    public init(spacing: CGFloat = 5) {
        self.spacing = spacing
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class Divider: UIView {
    private var weight: CGFloat?
    private var height: CGFloat?
    public var axis: NSLayoutConstraint.Axis? {
        didSet {
            translatesAutoresizingMaskIntoConstraints = false
            if let weight, let height {
                widthAnchor.constraint(equalToConstant: weight).isActive = true
                heightAnchor.constraint(equalToConstant: height).isActive = true
                return
            }
            let weight = weight ?? height ?? 1.0/UIScreen.main.scale
            switch axis {
            case .horizontal:
                widthAnchor.constraint(equalToConstant: weight).isActive = true
                heightAnchor.constraint(equalTo: superview!.heightAnchor).isActive = true
            case .vertical:
                widthAnchor.constraint(equalTo: superview!.widthAnchor).isActive = true
                heightAnchor.constraint(equalToConstant: weight).isActive = true
            default:
                break
            }
        }
    }
    public init(color: UIColor = .lightGray) {
        super.init(frame: .zero)
        backgroundColor = color
    }
    
    public func frame(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        self.weight = width
        self.height = height
        return self
    }
   
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func horizontal(weight: CGFloat = 1.0/UIScreen.main.scale, color: UIColor = .lightGray) -> Divider {
        return Divider(color: color).frame(width: weight)
    }
    public static func vertical(height: CGFloat = 1.0/UIScreen.main.scale, color: UIColor = .lightGray) -> Divider {
        return Divider(color: color).frame(height: height)
    }
}
