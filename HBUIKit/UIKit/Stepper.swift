//
//  Stepper.swift
//  HB
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
open class Stepper: UIStepper, HBControl {
    var store: Set<AnyCancellable>?
    
    public func isContinuous(_ isContinuous: Bool) -> Self {
        self.isContinuous = isContinuous
        return self
    }
    public func autorepeat(_ autorepeat: Bool) -> Self {
        self.autorepeat = autorepeat
        return self
    }
    public func wraps(_ wraps: Bool) -> Self {
        self.wraps = wraps
        return self
    }
    public func value(_ value: Double) -> Self {
        self.value = value
        return self
    }
    
    public func value(_ publiser: Published<Double>.Publisher) -> Self {
        publiser.assign(to: \.value, on: self).storeTo(self)
        return self
    }
    
    public func value<Root>(to keyPath: ReferenceWritableKeyPath<Root, Double>, on object: Root) -> Self {
        publisher(events: .valueChanged).map{$0.value}.assign(to: keyPath, on: object).storeTo(self)
        return self
    }
    
    public func minimumValue(_ minimumValue: Double) -> Self {
        self.minimumValue = minimumValue
        return self
    }
    public func maximumValue(_ maximumValue: Double) -> Self {
        self.maximumValue = maximumValue
        return self
    }
    public func stepValue(_ stepValue: Double) -> Self {
        self.stepValue = stepValue
        return self
    }
    public func backgroundImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setBackgroundImage(image, for: state)
        return self
    }
    public func dividerImage(_ image: UIImage?, forLeftSegmentState leftState: UIControl.State, rightSegmentState rightState: UIControl.State) -> Self {
        self.setDividerImage(image, forLeftSegmentState: leftState, rightSegmentState: rightState)
        return self
    }
    public func incrementImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setIncrementImage(image, for: state)
        return self
    }
    public func decrementImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setDecrementImage(image, for: state)
        return self
    }
}
