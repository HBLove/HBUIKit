//
//  Slider.swift
//  HB
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
open class Slider: UISlider, HBControl {
    var store: Set<AnyCancellable>?
    
    public func value(_ value: Float) -> Self {
        self.value = value
        return self
    }
    
    public func value(_ publisher: Published<Float>.Publisher) -> Self {
        publisher.assign(to: \.value, on: self).storeTo(self)
        return self
    }
    public func value<Root>(to keyPath: ReferenceWritableKeyPath<Root, Float>, on object: Root) -> Self{
        publisher(events: .valueChanged).map { $0.value }.assign(to: keyPath, on: object).storeTo(self)
        return self
    }
    
    public func minimumValue(_ minimumValue: Float) -> Self {
        self.minimumValue = minimumValue
        return self
    }
    public func maximumValue(_ maximumValue: Float) -> Self {
        self.maximumValue = maximumValue
        return self
    }
    public func minimumValueImage(_ minimumValueImage: UIImage?) -> Self {
        self.minimumValueImage = minimumValueImage
        return self
    }
    public func maximumValueImage(_ maximumValueImage: UIImage?) -> Self {
        self.maximumValueImage = maximumValueImage
        return self
    }
    public func isContinuous(_ isContinuous: Bool) -> Self {
        self.isContinuous = isContinuous
        return self
    }
    public func minimumTrackTintColor(_ minimumTrackTintColor: UIColor?) -> Self {
        self.minimumTrackTintColor = minimumTrackTintColor
        return self
    }
    public func maximumTrackTintColor(_ maximumTrackTintColor: UIColor?) -> Self {
        self.maximumTrackTintColor = maximumTrackTintColor
        return self
    }
    public func thumbTintColor(_ thumbTintColor: UIColor?) -> Self {
        self.thumbTintColor = thumbTintColor
        return self
    }
    public func thumbImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setThumbImage(image, for: state)
        return self
    }
    public func minimumTrackImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setMinimumTrackImage(image, for: state)
        return self
    }
    public func maximumTrackImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setMaximumTrackImage(image, for: state)
        return self
    }
}
