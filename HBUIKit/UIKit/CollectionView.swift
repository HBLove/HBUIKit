//
//  CollectionView.swift
//  HB
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
open class CollectionView: UICollectionView, HBScrollView {
    var store: Set<AnyCancellable>?
    
    // MARK: - Cell register and reuse
    public func registerCellNib<T: UICollectionViewCell>(_ type: T.Type) -> Self {
        registerCellWithNib(type)
        return self
    }
    
    public func registerCellClass<T: UICollectionViewCell>(_ type: T.Type) -> Self {
        registerCellWithClass(type)
        return self
    }
    
    // MARK: - Header register and reuse
    public func registerHeaderNib<T: UICollectionReusableView>(_ type: T.Type) -> Self {
        registerHeaderWithNib(type)
        return self
    }
    
    public func registerHeaderClass<T: UICollectionReusableView>(_ type: T.Type) -> Self {
        registerHeaderWithClass(type)
        return self
    }
    
    public func registerFooterNib<T: UICollectionReusableView>(_ type: T.Type) -> Self {
        registerFooterWithNib(type)
        return self
    }
    
    public func registerFooterClass<T: UICollectionReusableView>(_ type: T.Type) -> Self {
        registerFooterWithClass(type)
        return self
    }
    
    public func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) -> Self {
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
        return self
    }
    public func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) -> Self {
        self.register(nib, forCellWithReuseIdentifier: identifier)
        return self
    }
    public func register(_ viewClass: AnyClass?, forSupplementaryView elementKind: String, reuseIdentifier identifier: String) -> Self {
        self.register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        return self
    }
    public func register(_ nib: UINib?, forSupplementaryView kind: String, reuseIdentifier identifier: String) -> Self {
        self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        return self
    }
    
    public func collectionViewLayout(_ collectionViewLayout: UICollectionViewLayout) -> Self {
        self.collectionViewLayout = collectionViewLayout
        return self
    }
    public func delegate(_ delegate: UICollectionViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    public func dataSource(_ dataSource: UICollectionViewDataSource?) -> Self {
        self.dataSource = dataSource
        return self
    }
    public func prefetchDataSource(_ prefetchDataSource: UICollectionViewDataSourcePrefetching?) -> Self {
        self.prefetchDataSource = prefetchDataSource
        return self
    }
    public func isPrefetchingEnabled(_ isPrefetchingEnabled: Bool) -> Self {
        self.isPrefetchingEnabled = isPrefetchingEnabled
        return self
    }
    public func dragDelegate(_ dragDelegate: UICollectionViewDragDelegate?) -> Self {
        self.dragDelegate = dragDelegate
        return self
    }
    public func dropDelegate(_ dropDelegate: UICollectionViewDropDelegate?) -> Self {
        self.dropDelegate = dropDelegate
        return self
    }
    public func dragInteractionEnabled(_ dragInteractionEnabled: Bool) -> Self {
        self.dragInteractionEnabled = dragInteractionEnabled
        return self
    }
    public func reorderingCadence(_ reorderingCadence: UICollectionView.ReorderingCadence) -> Self {
        self.reorderingCadence = reorderingCadence
        return self
    }
    public func backgroundView(_ backgroundView: UIView?) -> Self {
        self.backgroundView = backgroundView
        return self
    }

    public func allowsSelection(_ allowsSelection: Bool) -> Self {
        self.allowsSelection = allowsSelection
        return self
    }
    public func allowsMultipleSelection(_ allowsMultipleSelection: Bool) -> Self {
        self.allowsMultipleSelection = allowsMultipleSelection
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
    public func isEditing(_ isEditing: Bool) -> Self {
        if #available(iOS 14.0, *) {
            self.isEditing = isEditing
        }
        return self
    }
    public func allowsSelectionDuringEditing(_ allowsSelectionDuringEditing: Bool) -> Self {
        if #available(iOS 14.0, *) {
            self.allowsSelectionDuringEditing = allowsSelectionDuringEditing
        }
        return self
    }
    public func allowsMultipleSelectionDuringEditing(_ allowsMultipleSelectionDuringEditing: Bool) -> Self {
        if #available(iOS 14.0, *) {
            self.allowsMultipleSelectionDuringEditing = allowsMultipleSelectionDuringEditing
        }
        return self
    }
}
