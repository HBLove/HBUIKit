//
//  ActivityIndicatorView.swift
//  HB
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
open class ActivityIndicatorView: UIActivityIndicatorView, HBView {
    var store: Set<AnyCancellable>?
    
    public func style(_ style: UIActivityIndicatorView.Style) -> Self {
        self.style = style
        return self
    }
    public func hidesWhenStopped(_ hidesWhenStopped: Bool) -> Self {
        self.hidesWhenStopped = hidesWhenStopped
        return self
    }
    public func color(_ color: UIColor!) -> Self {
        self.color = color
        self.startAnimating()
        return self
    }
    
    @discardableResult
    public func animating(_ animating: Bool) -> Self {
        if isAnimating, !animating {
            stopAnimating()
        } else if !isAnimating, animating {
            startAnimating()
        }
        return self
    }
    
    public func animating(_ publuser: Published<Bool>.Publisher) -> Self {
        publuser.sink {[weak self] isAnimating in
            self?.animating(isAnimating)
        }.storeTo(self)
        return self
    }
}
