//
//  ImageView.swift
//  HB
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
open class ImageView: UIImageView, HBView {
    var store: Set<AnyCancellable>?
    
    
    public func image(_ publisher: Published<UIImage?>.Publisher) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.image, on: self).storeTo(self)
        return self
    }
    
    public func highlightedImage(_ publisher: Published<UIImage?>.Publisher) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.highlightedImage, on: self).storeTo(self)
        return self
    }
    
    public func isHighlighted(_ publisher: Published<Bool>.Publisher) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.isHighlighted, on: self).storeTo(self)
        return self
    }
    
    
    public func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }
    
    public func highlightedImage(_ highlightedImage: UIImage?) -> Self {
        self.highlightedImage = highlightedImage
        return self
    }
  
    public func preferredSymbolConfiguration(_ preferredSymbolConfiguration: UIImage.SymbolConfiguration?) -> Self {
        self.preferredSymbolConfiguration = preferredSymbolConfiguration
        return self
    }
    
    public func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self
    }
    
    public func animationImages(_ animationImages: [UIImage]?) -> Self {
        self.animationImages = animationImages
        return self
    }
    public func highlightedAnimationImages(_ highlightedAnimationImages: [UIImage]?) -> Self {
        self.highlightedAnimationImages = highlightedAnimationImages
        return self
    }
    public func animationDuration(_ animationDuration: TimeInterval) -> Self {
        self.animationDuration = animationDuration
        return self
    }
    public func animationRepeatCount(_ animationRepeatCount: Int) -> Self {
        self.animationRepeatCount = animationRepeatCount
        return self
    }
    public func tintColor(_ tintColor: UIColor!) -> Self {
        self.tintColor = tintColor
        return self
    }
}
