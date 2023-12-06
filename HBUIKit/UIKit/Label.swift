//
//  Label.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/2.
//
import UIKit
import Combine
public class Label: UILabel, SwiftUIKitView {
    
    public convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    public func text(_ publisher: Published<String?>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.text, on: self).store(in: &store)
        return self
    }
    
    public func attributedText(_ publisher: Published<NSAttributedString?>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.attributedText, on: self).store(in: &store)
        return self
    }
    
    public func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
  
    public func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }
   
    public func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    public func color(_ color: UIColor?) -> Self {
        self.textColor = color
        return self
    }
    
    public func shadow(shadowColor: UIColor?, offset: CGSize? = nil) -> Self {
        self.shadowColor = shadowColor
        if let offset {
            self.shadowOffset = offset
        }
        return self
    }
    public func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    public func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        self.lineBreakMode = lineBreakMode
        return self
    }
   
    public func highlightedTextColor(_ highlightedTextColor: UIColor) -> Self {
        self.highlightedTextColor = highlightedTextColor
        return self
    }
    public func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self
    }
    public func isEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
    public func numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    public func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    public func baselineAdjustment(_ baselineAdjustment: UIBaselineAdjustment) -> Self {
        self.baselineAdjustment = baselineAdjustment
        return self
    }
    public func minimumScaleFactor(_ minimumScaleFactor: CGFloat) -> Self {
        self.minimumScaleFactor = minimumScaleFactor
        return self
    }
    public func allowsDefaultTighteningForTruncation(_ allowsDefaultTighteningForTruncation: Bool) -> Self {
        self.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
        return self
    }
    public func lineBreakStrategy(_ lineBreakStrategy: NSParagraphStyle.LineBreakStrategy) -> Self {
        if #available(iOS 14.0, *) {
            self.lineBreakStrategy = lineBreakStrategy
        }
        return self
    }
    public func preferredMaxLayoutWidth(_ preferredMaxLayoutWidth: CGFloat) -> Self {
        self.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        return self
    }
}
