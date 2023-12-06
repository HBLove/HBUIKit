//
//  TableView.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit

open class TableView: UITableView, SwiftUIKitScrollView {
    public func register(_ nib: UINib?, forCellIdentifier identifier: String) -> Self {
        self.register(nib, forCellReuseIdentifier: identifier)
        return self
    }
    public func register(_ cellClass: AnyClass?, forCellIdentifier identifier: String) -> Self {
        self.register(cellClass, forCellReuseIdentifier: identifier)
        return self
    }
    public func register(_ nib: UINib?, forHeaderFooterReuseIdentifier identifier: String) -> Self {
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
        return self
    }
    public func register(_ aClass: AnyClass?, forHeaderFooterIdentifier identifier: String) -> Self {
        self.register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
        return self
    }
    
    ///Register cell nib
    public func registerCellNib<T: UITableViewCell>(_ type: T.Type) -> Self {
        self.registerCellWithNib(type)
        return self
    }

     //Register cell class
    
    public func registerCellClass<T: UITableViewCell>(_ type: T.Type) -> Self {
        registerCellWithClass(type)
        return self
    }
    
    /**
     Register cell class
     
     - parameter type: class
     */
    public func registerHeaderFooterClass<T: UITableViewHeaderFooterView>(_ type: T.Type) -> Self {
        registerHeaderFooterWithClass(type)
        return self
    }
}


extension TableView {
    public func dataSourceAndDelegate(_ dataSource: UITableViewDataSource?, delegate: UITableViewDelegate?) -> Self {
        self.dataSource = dataSource
        self.delegate = delegate
        return self
    }

    public func prefetchDataSource(_ prefetchDataSource: UITableViewDataSourcePrefetching?) -> Self {
        self.prefetchDataSource = prefetchDataSource
        return self
    }
    public func isPrefetchingEnabled(_ isPrefetchingEnabled: Bool) -> Self {
        if #available(iOS 15.0, *) {
            self.isPrefetchingEnabled = isPrefetchingEnabled
        }
        return self
    }
    public func dragDelegate(_ dragDelegate: UITableViewDragDelegate?) -> Self {
        self.dragDelegate = dragDelegate
        return self
    }
    public func dropDelegate(_ dropDelegate: UITableViewDropDelegate?) -> Self {
        self.dropDelegate = dropDelegate
        return self
    }
    public func rowHeight(_ rowHeight: CGFloat) -> Self {
        self.rowHeight = rowHeight
        return self
    }
    public func sectionHeaderHeight(_ sectionHeaderHeight: CGFloat) -> Self {
        self.sectionHeaderHeight = sectionHeaderHeight
        return self
    }
    public func sectionFooterHeight(_ sectionFooterHeight: CGFloat) -> Self {
        self.sectionFooterHeight = sectionFooterHeight
        return self
    }
    public func estimatedRowHeight(_ estimatedRowHeight: CGFloat) -> Self {
        self.estimatedRowHeight = estimatedRowHeight
        return self
    }
    public func estimatedSectionHeaderHeight(_ estimatedSectionHeaderHeight: CGFloat) -> Self {
        self.estimatedSectionHeaderHeight = estimatedSectionHeaderHeight
        return self
    }
    public func estimatedSectionFooterHeight(_ estimatedSectionFooterHeight: CGFloat) -> Self {
        self.estimatedSectionFooterHeight = estimatedSectionFooterHeight
        return self
    }
    public func fillerRowHeight(_ fillerRowHeight: CGFloat) -> Self {
        if #available(iOS 15.0, *) {
            self.fillerRowHeight = fillerRowHeight
        }
        return self
    }
    public func sectionHeaderTopPadding(_ sectionHeaderTopPadding: CGFloat) -> Self {
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = sectionHeaderTopPadding
        }
        return self
    }
    public func separatorInset(_ separatorInset: UIEdgeInsets) -> Self {
        self.separatorInset = separatorInset
        return self
    }
    public func separatorInsetReference(_ separatorInsetReference: UITableView.SeparatorInsetReference) -> Self {
        self.separatorInsetReference = separatorInsetReference
        return self
    }
    public func backgroundView(_ backgroundView: UIView?) -> Self {
        self.backgroundView = backgroundView
        return self
    }
    public func isEditing(_ isEditing: Bool) -> Self {
        self.isEditing = isEditing
        return self
    }
    public func allowsSelection(_ allowsSelection: Bool) -> Self {
        self.allowsSelection = allowsSelection
        return self
    }
    public func allowsSelectionDuringEditing(_ allowsSelectionDuringEditing: Bool) -> Self {
        self.allowsSelectionDuringEditing = allowsSelectionDuringEditing
        return self
    }
    public func allowsMultipleSelection(_ allowsMultipleSelection: Bool) -> Self {
        self.allowsMultipleSelection = allowsMultipleSelection
        return self
    }
    public func allowsMultipleSelectionDuringEditing(_ allowsMultipleSelectionDuringEditing: Bool) -> Self {
        self.allowsMultipleSelectionDuringEditing = allowsMultipleSelectionDuringEditing
        return self
    }
    public func sectionIndexMinimumDisplayRowCount(_ sectionIndexMinimumDisplayRowCount: Int) -> Self {
        self.sectionIndexMinimumDisplayRowCount = sectionIndexMinimumDisplayRowCount
        return self
    }
    public func sectionIndexColor(_ sectionIndexColor: UIColor?) -> Self {
        self.sectionIndexColor = sectionIndexColor
        return self
    }
    public func sectionIndexBackgroundColor(_ sectionIndexBackgroundColor: UIColor?) -> Self {
        self.sectionIndexBackgroundColor = sectionIndexBackgroundColor
        return self
    }
    public func sectionIndexTrackingBackgroundColor(_ sectionIndexTrackingBackgroundColor: UIColor?) -> Self {
        self.sectionIndexTrackingBackgroundColor = sectionIndexTrackingBackgroundColor
        return self
    }
    public func separatorStyle(_ separatorStyle: UITableViewCell.SeparatorStyle) -> Self {
        self.separatorStyle = separatorStyle
        return self
    }
    public func separatorColor(_ separatorColor: UIColor?) -> Self {
        self.separatorColor = separatorColor
        return self
    }
    public func cellLayoutMarginsFollowReadableWidth(_ cellLayoutMarginsFollowReadableWidth: Bool) -> Self {
        self.cellLayoutMarginsFollowReadableWidth = cellLayoutMarginsFollowReadableWidth
        return self
    }
    public func insetsContentViewsToSafeArea(_ insetsContentViewsToSafeArea: Bool) -> Self {
        self.insetsContentViewsToSafeArea = insetsContentViewsToSafeArea
        return self
    }
    public func tableHeaderView(_ tableHeaderView: UIView?) -> Self {
        self.tableHeaderView = tableHeaderView
        return self
    }
    public func tableFooterView(_ tableFooterView: UIView?) -> Self {
        self.tableFooterView = tableFooterView
        return self
    }

    public func remembersLastFocusedIndexPath(_ remembersLastFocusedIndexPath: Bool) -> Self {
        self.remembersLastFocusedIndexPath = remembersLastFocusedIndexPath
        return self
    }
    public func selectionFollowsFocus(_ selectionFollowsFocus: Bool) -> Self {
        if #available(iOS 14.0, *) {
            self.selectionFollowsFocus = selectionFollowsFocus
        }
        return self
    }
    public func allowsFocus(_ allowsFocus: Bool) -> Self {
        if #available(iOS 15.0, *) {
            self.allowsFocus = allowsFocus
        }
        return self
    }
    public func allowsFocusDuringEditing(_ allowsFocusDuringEditing: Bool) -> Self {
        if #available(iOS 15.0, *) {
            self.allowsFocusDuringEditing = allowsFocusDuringEditing
        }
        return self
    }
    public func dragInteractionEnabled(_ dragInteractionEnabled: Bool) -> Self {
        self.dragInteractionEnabled = dragInteractionEnabled
        return self
    }
}
