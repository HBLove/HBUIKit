//
//  StackView.swift
//  HB
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
open class HStack: UIStackView, HBView {
    var store: Set<AnyCancellable>?
    
    public convenience init(distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 0, @ViewClosure views: () -> [UIView]) {
        let views = views()
        self.init(arrangedSubviews: views)
        views.forEach { view in
            if let spacer = view as? Spacer {
                spacer.axis = .horizontal
            } else if let divider = view as? Divider {
                divider.axis = .horizontal
            }
        }
        axis = .horizontal
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}

open class VStack: UIStackView, HBView {
    var store: Set<AnyCancellable>?
    public convenience init(distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 0, @ViewClosure views: () -> [UIView]) {
        let views = views()
        self.init(arrangedSubviews: views)
        views.forEach { view in
            if let spacer = view as? Spacer {
                spacer.axis = .vertical
            } else if let divider = view as? Divider {
                divider.axis = .vertical
            }
        }
        axis = .vertical
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}

open class ZStack: UIView, HBView {
    var store: Set<AnyCancellable>?
    
    public let alignment: ViewLayout.Alignment
    
    public init(alignment: ViewLayout.Alignment = .center, @ViewClosure views: () -> [UIView]) {
        self.alignment = alignment
        super.init(frame: .zero)
        views().forEach {
            ViewLayout.frame(view: $0, in: self, alignment: alignment)
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
