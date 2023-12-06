//
//  FileManager+Extension.swift
//  HB
//
//  Created by 黄波 on 2023/12/4.
//

import Foundation
public extension FileManager {
    class var  getTemPath: String {
        return NSTemporaryDirectory()
    }
    /**
     Get URL of Document directory.
     
     - returns: Document directory URL.
     */
    class func getDocumentURL() -> URL {
        return getURLForDirectory(.documentDirectory)!
    }
    
    /**
     Get String of Document directory.
     
     - returns: Document directory String.
     */
    class func getDocumentPath() -> String {
        return getPathForDirectory(.documentDirectory)!
    }
    
    /**
     Get URL of Library directory
     
     - returns: Library directory URL
     */
    class func getLibraryURL() -> URL {
        return getURLForDirectory(.libraryDirectory)!
    }
    
    /**
     Get String of Library directory
     
     - returns: Library directory String
     */
    class func getLibraryPath() -> String {
        return getPathForDirectory(.libraryDirectory)!
    }
    
    /**
     Get URL of Caches directory
     
     - returns: Caches directory URL
     */
    class func getCachesURL() -> URL {
        return getURLForDirectory(.cachesDirectory)!
    }
    
    /**
     Get String of Caches directory
     
     - returns: Caches directory String
     */
    class func getCachesPath() -> String {
        return getPathForDirectory(.cachesDirectory)!
    }
    
    /**
     Adds a special filesystem flag to a file to avoid iCloud backup it.
     
     - parameter filePath: Path to a file to set an attribute.
     */
    class func getAddSkipBackupAttributeToFile(_ filePath: String) {
        let url: URL = URL(fileURLWithPath: filePath)
        do {
            try (url as NSURL).setResourceValue(NSNumber(value: true as Bool), forKey: URLResourceKey.isExcludedFromBackupKey)
        } catch {}
    }
    
    /**
     Check available disk space in MB
     
     - returns: Double in MB
     */
    class func getAvailableDiskSpaceMb() -> Double {
        let fileAttributes = try? `default`.attributesOfFileSystem(forPath: getDocumentPath())
        if let fileSize = (fileAttributes![FileAttributeKey.systemSize] as AnyObject).doubleValue {
            return fileSize / Double(0x100000)
        }
        return 0
    }
    
    fileprivate class func getURLForDirectory(_ directory: FileManager.SearchPathDirectory) -> URL? {
        return `default`.urls(for: directory, in: .userDomainMask).last
    }
    
    fileprivate class func getPathForDirectory(_ directory: FileManager.SearchPathDirectory) -> String? {
        return NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true)[0]
    }
}
