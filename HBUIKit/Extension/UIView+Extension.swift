//
//  UIView+Extension.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/2.
//

import UIKit
// MARK: -  设置阴影
public enum HBShadowPathSide{
   case left
   case right
   case top
   case bottom
   case noTop //除了上面全部
   case all
}

public extension UIView {
    var currentController: UIViewController? {
        var nextResponder: UIResponder? = self
        repeat {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        } while nextResponder != nil

        return nil
    }
    
    // 生成 图片
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// - Parameters:
    ///   - withClass: UIView type.
    ///   - bundle: bundle of nib (default is nil).
    /// - Returns: UIView
    class func loadFromNib<T: UIView>(withClass name: T.Type, bundle: Bundle? = nil) -> T {
        let named = String(describing: name)
        guard let view = UINib(nibName: named, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? T else {
            fatalError("First element in xib file \(named) is not of type \(named)")
        }
        return view
    }
    
    /// 设置渐变色
    ///
    /// - Parameters:
    ///   - starColor: 开始的颜色
    ///   - endColor: 结束的颜色
    ///   - isDown: true:向下   false:向右
    func setGradientColor(size: CGSize? = nil,starColor: UIColor, endColor: UIColor, isDown: Bool)  {
        let rect = (size != nil) ? CGRect.init(origin: .zero, size: size!):bounds
        if let list = layer.sublayers  {
            for subLayer in list{
                if let gradient =  subLayer as? CAGradientLayer{
                    gradient.colors = [starColor.cgColor, endColor.cgColor]
                    subLayer.frame = rect
                    return
                }
            }
        }

        let gradient = CAGradientLayer()
        gradient.frame = rect
        if !isDown {
            gradient.startPoint = CGPoint.zero
            gradient.endPoint = CGPoint(x: 1, y: 0)
        }
        gradient.colors = [starColor.cgColor, endColor.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
    
    //毛玻璃
    @discardableResult func addBlurView(style: UIBlurEffect.Style = UIBlurEffect.Style.dark, alpha: CGFloat = 1) -> UIView{
        let blur = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = bounds
        blurView.alpha = alpha
        blurView.isUserInteractionEnabled = false
        addSubview(blurView)
        return blurView
    }
    
    //这个更好看 shadowWidth 宽度为总宽度一半
    func setShadow(viewFrame: CGRect,
                   type: HBShadowPathSide,
                   color: UIColor,
                   shadowWidth:CGFloat = .zero,
                   opacity: Float = 0.5,
                   radius:CGFloat = 3){
        
        clipsToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = .zero //消除之前偏移
        
        var shadowRect = CGRect.zero
        
        let originX: CGFloat = viewFrame.origin.x;
        let originY: CGFloat = viewFrame.origin.y;
        let originW: CGFloat = viewFrame.size.width;
        let originH: CGFloat = viewFrame.size.height;
        switch (type) {
        case .top:
            shadowRect  = CGRect(x:originX, y:originY - shadowWidth/2,width: originW, height: shadowWidth)
        case .bottom:
            shadowRect  = CGRect(x:originX,y:originH/2, width:originW, height:originH/2 + shadowWidth)
        case .left:
            shadowRect  = CGRect(x:originX - shadowWidth/2, y:originY, width:shadowWidth, height:originH)
        case .right:
            shadowRect  = CGRect(x:originW - shadowWidth/2,y: originY, width:shadowWidth,height:originH);
        case .noTop:
            shadowRect  = CGRect(x:originX - shadowWidth/2, y:originY + 1, width: originW + shadowWidth, height:originH + shadowWidth/2 )
     
        case .all:
            shadowRect  = CGRect(x:originX - shadowWidth/2,y: originY - shadowWidth/2,width:originW +  shadowWidth, height:originH + shadowWidth);
        }
        let path = UIBezierPath(rect: shadowRect)
        layer.shadowPath = path.cgPath
    }
}
