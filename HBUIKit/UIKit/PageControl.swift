//
//  PageControl.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
open class PageControl: UIPageControl, SwiftUIKitControl {
    public func numberOfPages(_ numberOfPages: Int) -> Self {
        self.numberOfPages = numberOfPages
        return self
    }
    public func currentPage(_ currentPage: Int) -> Self {
        self.currentPage = currentPage
        return self
    }
    
    public func currentPage(_ publisher: Published<Int>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publisher.assign(to: \.currentPage, on: self).store(in: &store)
        return self
    }
    
    public func currentPage<Root>(to keyPath: ReferenceWritableKeyPath<Root, Int>, on object: Root, store: inout Set<AnyCancellable>) -> Self {
        publisher(events: .valueChanged).map { $0.currentPage }.assign(to: keyPath, on: object).store(in: &store)
        return self
    }
    
    public func hidesForSinglePage(_ hidesForSinglePage: Bool) -> Self {
        self.hidesForSinglePage = hidesForSinglePage
        return self
    }
    public func pageIndicatorTintColor(_ pageIndicatorTintColor: UIColor?) -> Self {
        self.pageIndicatorTintColor = pageIndicatorTintColor
        return self
    }
    public func currentPageIndicatorTintColor(_ currentPageIndicatorTintColor: UIColor?) -> Self {
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        return self
    }
    public func backgroundStyle(_ backgroundStyle: Int) -> Self {
        if #available(iOS 14.0, *), let backgroundStyle = PageControl.BackgroundStyle.init(rawValue: backgroundStyle) {
            self.backgroundStyle = backgroundStyle
        }
        return self
    }
    public func allowsContinuousInteraction(_ allowsContinuousInteraction: Bool) -> Self {
        if #available(iOS 14.0, *) {
            self.allowsContinuousInteraction = allowsContinuousInteraction
        }
        return self
    }
    public func preferredIndicatorImage(_ preferredIndicatorImage: UIImage?) -> Self {
        if #available(iOS 14.0, *) {
            self.preferredIndicatorImage = preferredIndicatorImage
        }
        return self
    }
    public func indicatorImage(_ image: UIImage?, forPage page: Int) -> Self {
        if #available(iOS 14.0, *) {
            self.setIndicatorImage(image, forPage: page)
        }
        return self
    }
    @available(iOS, introduced: 2.0, deprecated: 14.0, message: "updateCurrentPageDisplay no longer does anything reasonable with the new interaction mode.")
    public func defersCurrentPageDisplay(_ defersCurrentPageDisplay: Bool) -> Self {
        self.defersCurrentPageDisplay = defersCurrentPageDisplay
        return self
    }
}
