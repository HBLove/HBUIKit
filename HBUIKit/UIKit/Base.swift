//
//  HBView.swift
//  HB
//
//  Created by 黄波 on 2023/11/22.
//

import UIKit
public protocol HBBase: UIView{}

extension HBBase {
    
    public func then(_ body: (Self) -> Void) -> Self {
        body(self)
        return self
    }
 
    
    public func background<T: UIView>(alignment: ViewLayout.Alignment = .center,  content: () -> T) -> View {
        let view = offset(0,0)
        let content = content()
        ViewLayout.frame(view: content, in: view, alignment: alignment, isBack: true, isContain: false)
        return view
    }
    
    public func overlay<T: HBBase>(alignment: ViewLayout.Alignment = .center,  content: () -> T) -> View {
        let view = offset(0,0)
        let content = content()
        ViewLayout.frame(view: content, in: view, alignment: alignment, isContain: false)
        return view
    }
    
    // 根据宽高 生成一个新的View 只能更大,
    public func frame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: ViewLayout.Alignment = .center) -> View {
        let minSize = getMinSize()
        if let width, width <= minSize.width {
            fatalError("宽度需要比需求的要小")
        } else if let height, height <= minSize.height {
            fatalError("高度需要比需求的要小")
        }
        
        let view = View(width: width, height: height)
        view.minSize = CGSize(width: width ?? minSize.width, height: height ?? minSize.height)
        ViewLayout.frame(view: self, in: view, alignment: alignment)
        return view
    }

    public func offset(x: CGFloat? = nil, y: CGFloat? = nil) -> View {
        if (x == nil && y == nil) || (x == 0 || y == 0)  {
            fatalError("x y 不能同时为nil 或者 0")
        }
        
        return offset(x ?? 0, y ?? 0)
    }
    
    private func offset(_ x: CGFloat, _ y: CGFloat) -> View {
        let minSize = getMinSize()
        let view = View()
        view.minSize = minSize
        ViewLayout.offset(x: x, y: y, view: self, in: view)
        return view
    }
    
    public func padding(_ padding: UIEdgeInsets) -> View {
        guard padding != .zero, padding.left >= 0 || padding.top >= 0 || padding.bottom >= 0 || padding.right >= 0 else {
            fatalError("padding 边长必须大于0")
        }
        let minSize = getMinSize()
        let view = View()
        view.minSize = CGSize(width: minSize.width + padding.width, height: minSize.height + padding.height)
        ViewLayout.padding(padding, view: self, in: view)
        return view
    }
    
    public func padding(_ edge: UIEdgeInsets.Edges = .all,  _ length: CGFloat) -> View {
        return padding(UIEdgeInsets.init(edge, length: length))
    }
    public func padding(_ length: CGFloat) -> View {
        return padding(UIEdgeInsets.init(.all, length: length))
    }
    
    // 判断是否有宽高
    func getMinSize() -> CGSize {
        if let view = self as? View {
            return view.minSize
        }
        var size = CGSize.zero
        constraints.forEach { constraint in
            if constraint.isActive, constraint.firstAttribute == .width, constraint.secondAttribute == .notAnAttribute {
                size.width = constraint.constant
            } else if constraint.isActive, constraint.firstAttribute == .height, constraint.secondAttribute == .notAnAttribute {
                size.height = constraint.constant
            }
        }
        return size
    }
}

// MARK: 事件
extension HBBase {
    var eventMaganer: ViewEventMaganer? {
        get { getAssociated(function: #function) }
        set { setAssociated(newValue: newValue, function: #function) }
    }
    
    public func getEventMaganer() -> ViewEventMaganer {
        if eventMaganer == nil {
            eventMaganer = ViewEventMaganer()
        }
        return eventMaganer!
    }
    // MARK: 手势
    @discardableResult
    public func onGesture<T: UIGestureRecognizer>(gesture: T, action: @escaping (T) -> Void) -> Self {
        getEventMaganer().addGesture(gesture: gesture, onEventHandler: { sender in
            guard let sender = sender as? T else { return }
            action(sender)
        })
        return self
    }
}

public extension UIView {
    convenience init(width: CGFloat) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    convenience init(height: CGFloat) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    convenience init(width: CGFloat?, height: CGFloat?) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        if let width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
