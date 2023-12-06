//
//  Control.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
protocol SwiftUIKitControl: UIControl, SwiftUIKitView {}

open class Control: UIControl, SwiftUIKitControl {}

// MARK: combine
extension SwiftUIKitControl {
    public func isEnabled(_ publisher: Published<Bool>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.isEnabled, on: self).store(in: &store)
        return self
    }
    
    public func isHighlighted(_ publisher: Published<Bool>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.isHighlighted, on: self).store(in: &store)
        return self
    }
    
    public func isSelected(_ publisher: Published<Bool>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.isSelected, on: self).store(in: &store)
        return self
    }
    
    public func publisher(events: UIControl.Event) -> Publishers.UIControlPublisher<Self> {
        return Publishers.UIControlPublisher(control: self, events: events)
    }
    
}

extension SwiftUIKitControl {
    public func isEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
    public func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self
    }
  
    public func isSelected(_ isSelected: Bool) -> Self {
        self.isSelected = isSelected
        return self
    }
    
    public func target(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> Self {
        addTarget(target, action: action, for: controlEvents)
        return self
    }
    public func contentVerticalAlignment(_ contentVerticalAlignment: UIControl.ContentVerticalAlignment) -> Self {
        self.contentVerticalAlignment = contentVerticalAlignment
        return self
    }
    public func contentHorizontalAlignment(_ contentHorizontalAlignment: UIControl.ContentHorizontalAlignment) -> Self {
        self.contentHorizontalAlignment = contentHorizontalAlignment
        return self
    }
    
    @discardableResult
    public func onPress(for event: UIControl.Event, action: @escaping (Self) -> Void) -> Self {
        eventMaganer?.addAction(control: self, event: event, onEventHandler: { sender in
            guard let control = sender as? Self else { return }
            action(control)
        })
        return self
    }
}

