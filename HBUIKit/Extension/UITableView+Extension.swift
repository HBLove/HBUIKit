//
//  UITableView+Extension.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/22.
//

import UIKit

public extension UITableView{
    
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    ///Register cell nib
    func registerCellWithNib<T: UITableViewCell>(_ type: T.Type) {
        let name = String(describing: type)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellReuseIdentifier: name)
    }

     //Register cell class
    
    func registerCellWithClass<T: UITableViewCell>(_ type: T.Type) {
        let name = String(describing: type)
        self.register(type, forCellReuseIdentifier: name)
    }
    
    // Reusable Cell
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T {
        let name = String(describing: type)
        guard let cell = dequeueReusableCell(withIdentifier: name) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, cellId: String) -> T {
        var cell = dequeueReusableCell(withIdentifier: cellId) as? T
        if cell == nil {
            cell = T.init(style: .default, reuseIdentifier: cellId)
        }
        return cell!
    }
    
    // MARK: - HeaderFooter register and reuse
    func degisterHeaderFooterNib<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        let name = String(describing: type)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: name)
    }
    
    /**
     Register cell class
     
     - parameter type: class
     */
    func registerHeaderFooterWithClass<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        let name = String(describing: type)
        self.register(type, forHeaderFooterViewReuseIdentifier: name)
    }
    
    /**
     Reusable Cell
     
     - parameter type:    class
     
     - returns: cell
     */
    func dequeueReusableHeaderFooter<T: UIView>(_ type: T.Type) -> T! {
        let name = String(describing: type)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: name) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
}
