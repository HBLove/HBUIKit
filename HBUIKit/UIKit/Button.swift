//
//  Button.swift
//  HB
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
open class Button: UIButton, HBControl {
    var store: Set<AnyCancellable>?
    
    public func title(_ publisher: Published<String?>.Publisher, for state: UIControl.State) -> Self {
        publisher.receive(on: RunLoop.main).sink {[weak self] title in
            self?.setTitle(title, for: state)
        }.storeTo(self)
        return self
    }
    
    public func titleColor(_ publisher: Published<UIColor?>.Publisher, for state: UIControl.State) -> Self {
        publisher.receive(on: RunLoop.main).sink { [weak self] color in
            self?.setTitleColor(color, for: state)
        }.storeTo(self)
        return self
    }
    
    public func titleShadowColor(_ publisher: Published<UIColor?>.Publisher, for state: UIControl.State) -> Self {
        publisher.receive(on: RunLoop.main).sink { [weak self] color in
            self?.setTitleShadowColor(color, for: state)
        }.storeTo(self)
        return self
    }
    
    public func image(_ publisher: Published<UIImage?>.Publisher, for state: UIControl.State) -> Self {
        publisher.receive(on: RunLoop.main).sink { [weak self] image in
            self?.setImage(image, for: state)
        }.storeTo(self)
        return self
    }
    
    public func backgroundImage(_ publisher: Published<UIImage?>.Publisher, for state: UIControl.State) -> Self {
        publisher.receive(on: RunLoop.main).sink { [weak self] image in
            self?.setBackgroundImage(image, for: state)
        }.storeTo(self)
        return self
    }
    
    public func attributedTitle(_ publisher: Published<NSAttributedString?>.Publisher, for state: UIControl.State) -> Self {
        publisher.receive(on: RunLoop.main).sink { [weak self] att in
            self?.setAttributedTitle(att, for: state)
        }.storeTo(self)
        return self
    }
}

extension Button {
    public func title(_ title: String?, for state: UIControl.State) -> Self {
        self.setTitle(title, for: state)
        return self
    }
    
    public func titleColor(_ color: UIColor?, for state: UIControl.State) -> Self {
        self.setTitleColor(color, for: state)
        return self
    }
    
    public func titleShadowColor(_ color: UIColor?, for state: UIControl.State) -> Self {
        self.setTitleShadowColor(color, for: state)
        return self
    }
    
    public func image(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setImage(image, for: state)
        return self
    }
   
    public func backgroundImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setBackgroundImage(image, for: state)
        return self
    }
   
    public func attributedTitle(_ title: NSAttributedString?, for state: UIControl.State) -> Self {
        self.setAttributedTitle(title, for: state)
        return self
    }
    
    public func font(_ font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }
    public func contentEdgeInsets(_ contentEdgeInsets: UIEdgeInsets) -> Self {
        self.contentEdgeInsets = contentEdgeInsets
        return self
    }
    public func titleEdgeInsets(_ titleEdgeInsets: UIEdgeInsets) -> Self {
        self.titleEdgeInsets = titleEdgeInsets
        return self
    }
    public func reversesTitleShadowWhenHighlighted(_ reversesTitleShadowWhenHighlighted: Bool) -> Self {
        self.reversesTitleShadowWhenHighlighted = reversesTitleShadowWhenHighlighted
        return self
    }
    public func imageEdgeInsets(_ imageEdgeInsets: UIEdgeInsets) -> Self {
        self.imageEdgeInsets = imageEdgeInsets
        return self
    }
    public func adjustsImageWhenHighlighted(_ adjustsImageWhenHighlighted: Bool) -> Self {
        self.adjustsImageWhenHighlighted = adjustsImageWhenHighlighted
        return self
    }
    public func adjustsImageWhenDisabled(_ adjustsImageWhenDisabled: Bool) -> Self {
        self.adjustsImageWhenDisabled = adjustsImageWhenDisabled
        return self
    }
    public func showsTouchWhenHighlighted(_ showsTouchWhenHighlighted: Bool) -> Self {
        self.showsTouchWhenHighlighted = showsTouchWhenHighlighted
        return self
    }
    public func tintColor(_ tintColor: UIColor!) -> Self {
        self.tintColor = tintColor
        return self
    }
    @available(iOS 14.0, *)
    public func role(_ role: UIButton.Role) -> Self {
        self.role = role
        return self
    }
    public func isPointerInteractionEnabled(_ isPointerInteractionEnabled: Bool) -> Self {
        if #available(iOS 13.4, *) {
            self.isPointerInteractionEnabled = isPointerInteractionEnabled
        }
        return self
    }
    public func preferredSymbolConfiguration(_ configuration: UIImage.SymbolConfiguration?, forImageIn state: UIControl.State) -> Self {
        self.setPreferredSymbolConfiguration(configuration, forImageIn: state)
        return self
    }
  
    @available(iOS 13.4, *)
    public func pointerStyleProvider(_ pointerStyleProvider: UIButton.PointerStyleProvider?) -> Self {
        self.pointerStyleProvider = pointerStyleProvider
        return self
    }
}
