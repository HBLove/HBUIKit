//
//  Bundle+Extension.swift
//  HB
//
//  Created by 黄波 on 2023/12/4.
//

import Foundation
public extension Bundle{
    /// The app's name
    static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    /// The app's version
    static var appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    /// The app's build number
//    static var hbAppBuild: String {
//        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
//    }
    
//    / The app's bundle identifier
    static var appBundleIdentifier: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    /// The app's bundle name
//    static var hbBundleName: String {
//        return Bundle.main.infoDictionary!["CFBundleName"] as! String
//    }
    
//
//    /// App's icon file path
//    class var appAssetPath: String {
//        let iconFilename = Bundle.main.object(forInfoDictionaryKey: "CFBundleIconFile")
//        let iconBasename = (iconFilename as! NSString).deletingPathExtension
//        let iconExtension = (iconFilename as! NSString).pathExtension
//        return Bundle.main.path(forResource: iconBasename, ofType: iconExtension)!
//    }
//
    
    
//    版本号对比
    class func hbChenckNewVersion(_ new: String)->Bool {
        let locationVersion = appVersion
        let curList = locationVersion.components(separatedBy: ".")
        let newList = new.components(separatedBy: ".")
              
        let num = max(curList.count, newList.count)
        for i in 0..<num {
            let v1 = curList.count > i ? curList[i]:"0"
            let v2 = newList.count > i ? newList[i]:"0"
            if v1.compare(v2) == .orderedAscending{
                return true
            }else if v1.compare(v2) == .orderedDescending{
                return false
            }
        }
        return false
    }
}
