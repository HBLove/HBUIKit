//
//  NSObject+Extension.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/2.
//

import Foundation
public extension NSObject {
    var className: String{
//       String(reflecting: <#T##Subject#>)空间名
        return String(describing: type(of: self)) //名字
    }
    
    class func swizzleMethod(origin selector: Selector, swizzle newSelector: Selector)  {
    
        let originMethod = class_getInstanceMethod(self, selector)
        let swizzleMethod = class_getInstanceMethod(self, newSelector)
        /*
         周全起见，有两种情况要考虑一下
              第一种情况：要交换的方法并没有在目标类中实现，而是在其父类中实现了, 这时使用class_getInstanceMethod函数获取到的originalSelector指向的就是父类的方法
              第二种情况：要交换的方法已经存在于目标类中
         
         注意： dynamic 修饰方法 origin 如果交换失败 特别是一些cocospad第三方库修改时
         ///dynamic 关键字可以用于修饰变量或函数，它的意思也与 Objective-C 完全不同。她告诉编译器使用动态分发而不是静态分发。Objective-C 区别于其他语言的一个特点在于它的动态性，任何方法调用实际上都是消息分发，而 Swift 则尽可能做到静态分发。
         
         */
        guard let swMethod = swizzleMethod, let oMethod = originMethod else { return }
        let didAddSuccess: Bool = class_addMethod(self, selector, method_getImplementation(swMethod), method_getTypeEncoding(swMethod))
        
        if didAddSuccess {
            class_replaceMethod(self, newSelector, method_getImplementation(oMethod), method_getTypeEncoding(oMethod))
        } else {
            method_exchangeImplementations(oMethod, swMethod)
        }
    }
    
    func getAssociated<T>(function: String) -> T? {
        let key = unsafeBitCast(Selector(function), to: UnsafeRawPointer.self)
        return objc_getAssociatedObject(self, key) as? T
    }
    
    func setAssociated<T>(newValue: T, function: String, policy: objc_AssociationPolicy? = nil) {
        let key = unsafeBitCast(Selector(function), to: UnsafeRawPointer.self)
        objc_setAssociatedObject(self, key, newValue, policy ?? .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
