//
//  SwiftUIKit.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/2.
//
import UIKit 
import Combine
public protocol SwiftUIKitView: SwiftUIKitBase {}

open class View: UIView, SwiftUIKitView {
    var minSize = CGSize.zero
}

extension SwiftUIKitView {
    public func isUserInteractionEnabled(_ publisher: Published<Bool>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.isUserInteractionEnabled, on: self).store(in: &store)
        return self
    }
    public func backgroundColor(_ publusher: Published<UIColor?>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publusher.assign(to: \.backgroundColor, on: self).store(in: &store)
        return self
    }
    
    public func isHidden(_ publusher: Published<Bool>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publusher.assign(to: \.isHidden, on: self).store(in: &store)
        return self
    }
    
    public func alpha(_ publusher: Published<CGFloat>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publusher.assign(to: \.alpha, on: self).store(in: &store)
        return self
    }
    
    public func assign<T>(_ publusher: Published<T>.Publisher, to keyPath: ReferenceWritableKeyPath<Self, T>, store: inout Set<AnyCancellable>) -> Self {
        publusher.assign(to: keyPath, on: self).store(in: &store)
        return self
    }
}

extension SwiftUIKitView {
    public func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    
    public func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    public func focusGroupIdentifier(_ focusGroupIdentifier: String?) -> Self {
        if #available(iOS 14.0, *) {
            self.focusGroupIdentifier = focusGroupIdentifier
        }
        return self
    }
    public func focusGroupPriority(_ focusGroupPriority: UIFocusGroupPriority) -> Self {
        if #available(iOS 15.0, *) {
            self.focusGroupPriority = focusGroupPriority
        }
        return self
    }
    @available(iOS 15.0, *)
    public func focusEffect(_ focusEffect: UIFocusEffect?) -> Self {
        self.focusEffect = focusEffect
        return self
    }
    // 兼容
    public func focusEffect(_ body: () -> NSObject?) -> Self {
        if #available(iOS 15.0, *), let focusEffect = body() as? UIFocusEffect {
            self.focusEffect = focusEffect
        }
        return self
    }
    
    public func semanticContentAttribute(_ semanticContentAttribute: UISemanticContentAttribute) -> Self {
        self.semanticContentAttribute = semanticContentAttribute
        return self
    }
    public func transform(_ transform: CGAffineTransform) -> Self {
        self.transform = transform
        return self
    }
    public func transform3D(_ transform3D: CATransform3D) -> Self {
        self.transform3D = transform3D
        return self
    }
    public func contentScaleFactor(_ contentScaleFactor: CGFloat) -> Self {
        self.contentScaleFactor = contentScaleFactor
        return self
    }
    public func isMultipleTouchEnabled(_ isMultipleTouchEnabled: Bool) -> Self {
        self.isMultipleTouchEnabled = isMultipleTouchEnabled
        return self
    }
    public func isExclusiveTouch(_ isExclusiveTouch: Bool) -> Self {
        self.isExclusiveTouch = isExclusiveTouch
        return self
    }
    public func clipsToBounds(_ clipsToBounds: Bool) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }
    public func backgroundColor(_ backgroundColor: UIColor?) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }
  
    public func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
 
    public func isOpaque(_ isOpaque: Bool) -> Self {
        self.isOpaque = isOpaque
        return self
    }
    public func clearsContextBeforeDrawing(_ clearsContextBeforeDrawing: Bool) -> Self {
        self.clearsContextBeforeDrawing = clearsContextBeforeDrawing
        return self
    }
    public func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    public func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
    public func mask(_ mask: UIView?) -> Self {
        self.mask = mask
        return self
    }
    public func tintColor(_ tintColor: UIColor!) -> Self {
        self.tintColor = tintColor
        return self
    }
    public func tintAdjustmentMode(_ tintAdjustmentMode: UIView.TintAdjustmentMode) -> Self {
        self.tintAdjustmentMode = tintAdjustmentMode
        return self
    }
    public func restorationIdentifier(_ restorationIdentifier: String?) -> Self {
        self.restorationIdentifier = restorationIdentifier
        return self
    }
    
    public func overrideUserInterfaceStyle(_ overrideUserInterfaceStyle: UIUserInterfaceStyle) -> Self {
        self.overrideUserInterfaceStyle = overrideUserInterfaceStyle
        return self
    }
    public func contentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentHuggingPriority(priority, for: axis)
        return self
    }
    public func contentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
}

// MARK: layer
extension SwiftUIKitView {
    public func cornerRadius(_ cornerRadius: CGFloat, maskedCorners: CACornerMask? = nil, masksToBounds: Bool? = nil) -> Self {
        layer.cornerRadius = cornerRadius
        if let maskedCorners {
            layer.maskedCorners = maskedCorners
        } else if let masksToBounds {
            layer.masksToBounds = masksToBounds
        }
        return self
    }
    
    public func cornerCurve(_ cornerCurve: CALayerCornerCurve) -> Self {
        layer.cornerCurve = cornerCurve
        return self
    }
    public func border(_ width: CGFloat, color: UIColor) -> Self {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }
    public func shadow(_ color: UIColor?, radius: CGFloat? = nil, offset: CGSize? = nil, opacity: Float? = nil) -> Self {
        layer.shadowColor = color?.cgColor
        if let opacity {
            layer.shadowOpacity = opacity
        }
        if let offset {
            layer.shadowOffset = offset
        }
        if let radius {
            layer.shadowRadius = radius
        }
        return self
    }
    public func shadowPath(_ shadowPath: CGPath?) -> Self {
        layer.shadowPath = shadowPath
        return self
    }
    
}
