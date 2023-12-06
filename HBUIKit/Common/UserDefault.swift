//
//  UserDefault.swift
//  HB
//
//  Created by 黄波 on 2023/12/4.
//

import UIKit

@propertyWrapper
public struct UserDefault<T> {
    public let key: String
    // 默认值
    public let defaultValue: T
    
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if let obj = newValue as? AnyOptional, obj.isNil {
                UserDefaults.standard.removeObject(forKey: key)
                return
            }
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

extension UserDefault where T: ExpressibleByNilLiteral {
    public init(key: String) {
        self.init(key: key, defaultValue: nil)
    }
}


public protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}
