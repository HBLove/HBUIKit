//
//  UICollectionView+Extension.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/22.
//

import UIKit

public extension UICollectionView{
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    // MARK: - Cell register and reuse
    func registerCellWithNib<T: UICollectionViewCell>(_ type: T.Type) {
        let name = String(describing: type)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: name)
    }
    
    func registerCellWithClass<T: UICollectionViewCell>(_ type: T.Type) {
        let name = String(describing: type)
        self.register(type, forCellWithReuseIdentifier: name)
    }
    
    
    // Dequeue reusable cell
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        let name = String(describing: type)
        guard let cell = dequeueReusableCell(withReuseIdentifier: name, for: indexPath) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
    
    // MARK: - Header register and reuse
    func registerHeaderWithNib<T: UICollectionReusableView>(_ type: T.Type) {
        let name = String(describing: type)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: name)
    }
    
    func registerHeaderWithClass<T: UICollectionReusableView>(_ type: T.Type) {
        let name = String(describing: type)
        self.register(type, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: name)
    }
    
    func dequeueReusableHeader<T: UICollectionReusableView>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T! {
        let name = String(describing: type)
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: name,
            for: indexPath) as? T else {
                fatalError("\(name) is not registed")
        }
        return view
    }
    
    func registerFooterWithNib<T: UICollectionReusableView>(_ type: T.Type) {
        let name = String(describing: type)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: name)
    }
    
    func registerFooterWithClass<T: UICollectionReusableView>(_ type: T.Type) {
        let name = String(describing: type)
        self.register(type, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: name)
    }
    

    func dequeueReusableFooter<T: UICollectionReusableView>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T! {
        let name = String(describing: type)
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: name,
            for: indexPath) as? T else {
                fatalError("\(name) is not registed")
        }
        return view
    }
}
