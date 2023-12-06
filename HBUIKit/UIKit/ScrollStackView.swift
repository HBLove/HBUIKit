//
//  ScrollStackView.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/22.
//

import UIKit

extension ScrollView {
    fileprivate func layoutSizeFit(view: UIView, ignoreSafeArea: Bool = false)  {
       addSubview(view)
       view.translatesAutoresizingMaskIntoConstraints = false
       var top = view.topAnchor
       var leading = view.leadingAnchor
       var bottom = view.bottomAnchor
       var trailing = view.trailingAnchor
       if !ignoreSafeArea {
           top = view.safeAreaLayoutGuide.topAnchor
           leading = view.safeAreaLayoutGuide.leadingAnchor
           bottom = view.safeAreaLayoutGuide.bottomAnchor
           trailing = view.safeAreaLayoutGuide.trailingAnchor
       }
       NSLayoutConstraint.activate([
           view.topAnchor.constraint(greaterThanOrEqualTo: top),
           view.leadingAnchor.constraint(greaterThanOrEqualTo: leading),
           view.bottomAnchor.constraint(equalTo: bottom),
           view.trailingAnchor.constraint(equalTo: trailing),
       ])
   }
}

/// The width and height of `HScrollStack` is required
open class HScrollStack: ScrollView {
    private let stackView: UIStackView
    public let scrollView: UIScrollView
    public init(distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 0, @ViewClosure views: () -> [UIView]) {
        
        let views = views()
        scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        stackView = UIStackView(arrangedSubviews: views)
        views.forEach { view in
            if let spacer = view as? Spacer {
                spacer.axis = .horizontal
            } else if let divider = view as? Divider {
                divider.axis = .horizontal
            }
        }
        stackView.axis = .horizontal
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = spacing
        super.init(frame: .zero)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        layoutSizeFit(view: stackView, ignoreSafeArea: true)
        stackView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        stackView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor).isActive = true
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// The width and height of `VScrollStack` is required
open class VScrollStack: ScrollView {
    private let stackView: UIStackView
    public init(distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 0, @ViewClosure views: () -> [UIView]) {
        
        let views = views()
        stackView = UIStackView(arrangedSubviews: views)
        views.forEach { view in
            if let spacer = view as? Spacer {
                spacer.axis = .vertical
            } else if let divider = view as? Divider {
                divider.axis = .vertical
            }
        }
        stackView.axis = .vertical
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = spacing
        stackView.backgroundColor = .blue
        super.init(frame: .zero)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        layoutSizeFit(view: stackView, ignoreSafeArea: true)
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        stackView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor).isActive = true
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
