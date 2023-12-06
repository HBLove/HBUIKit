//
//  Switch.swift
//  HB
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
open class Switch: UISwitch, HBControl {
    var store: Set<AnyCancellable>?
    
    public func resizable() -> Self {
        let size = getMinSize()
        guard size != .zero else { return self }
        sizeToFit()
        let origalSize = frame.size
        let x = size.width / origalSize.width
        let y = size.height / origalSize.height
        let scaleTransform = CGAffineTransform(scaleX: x, y: y)
        transform = CGAffineTransformTranslate(scaleTransform, -x/4, -y/4)
        return self
    }
    
    public func isOn(_ isOn: Bool) -> Self {
        self.isOn = isOn
        return self
    }
    
    public func isOn(_ publisher: Published<Bool>.Publisher) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.isOn, on: self).storeTo(self)
        return self
    }
    public func isOn<Root>(to keyPath: ReferenceWritableKeyPath<Root, Bool>, on object: Root) -> Self{
        publisher(events: .valueChanged).map { $0.isOn }.receive(on: RunLoop.main).assign(to: keyPath, on: object).storeTo(self)
        return self
    }
    
    public func onTintColor(_ onTintColor: UIColor?) -> Self {
        self.onTintColor = onTintColor
        return self
    }
    public func thumbTintColor(_ thumbTintColor: UIColor?) -> Self {
        self.thumbTintColor = thumbTintColor
        return self
    }
    public func onImage(_ onImage: UIImage?) -> Self {
        self.onImage = onImage
        return self
    }
    public func offImage(_ offImage: UIImage?) -> Self {
        self.offImage = offImage
        return self
    }
    
    public func title(_ title: String?) -> Self {
        if #available(iOS 14.0, *) {
            self.title = title
        }
        return self
    }
    @available(iOS 14.0, *)
    public func preferredStyle(_ preferredStyle: UISwitch.Style) -> Self {
        self.preferredStyle = preferredStyle
        return self
    }

}
