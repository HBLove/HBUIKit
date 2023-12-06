//
//  String+Extension.swift
//  HB
//
//  Created by 黄波 on 2023/12/4.
//

import Foundation
import UIKit
// MARK: - 方法
public extension String{
    /// 复制
    #if os(iOS) || os(macOS)
    /// SwifterSwift: Copy string to global pasteboard.
    ///
    ///        "SomeText".copyToPasteboard() // copies "SomeText" to pasteboard
    ///
    func copyToPasteboard() {
        #if os(iOS)
        UIPasteboard.general.string = self
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(self, forType: .string)
        #endif
    }
    #endif
    
    var url: URL?{
        //中文
        if let url = URL(string: self) {
            return url
        }
        guard let str = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
            return nil
        }
        return URL(string: str)
    }
    // url 的编码解码
    var urlEncoded: String? {
        return removingPercentEncoding ?? self
    }
    
    func matchs(for regex: String) -> [NSTextCheckingResult]?{
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            let matches = regex.matches(in: self, options: .reportProgress, range: .init(location: 0, length: count))
            return matches
        } catch {
            print("文字匹配出错")
            return nil
        }
    }
    
    func find(subString: String) -> [NSTextCheckingResult]?{
        return matchs(for: "?\(subString)")
    }
}
// MARK: - nsstring -> string
public extension String {
    var nsString: NSString {
        return NSString(string: self)
    }
    var fullNSRange: NSRange{
        return  NSRange(startIndex..<endIndex, in: self)
    }
    func range(from nsRange: NSRange) -> Range<Index>? {
        return Range(nsRange, in: self)
    }
    /// - Parameter range: The `Range<String.Index>` within the receiver.
    /// - Returns: The equivalent `NSRange` of `range` found within the receiving string.
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}

// MARK: - 字符修剪 截取
public extension String {
    /// 两边的空格换行
    ///"   hello  \n".trimmed -> "hello"
    ///
    var trimmed: String{
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    ///所有的空可换行
    /// " sOme vAriable naMe \n" -> "sOmevAriablenaMe"
    var tirmmedAll: String{
        return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
    /// 是否有空格
    var isWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    ///        "Hello World!"[safe: 3] -> "l"
    ///        "Hello World!"[safe: 20] -> nil
    /// 截取
    /// - Parameter index: index.
    subscript(safe index: Int) -> Character? {
        guard index >= 0, index < count else { return nil }
        return self[self.index(startIndex, offsetBy: index)]
    }
    ///        "Hello World!"[safe: 6..<11] -> "World"
    ///        "Hello World!"[safe: 21..<110] -> nil
    ///
    ///        "Hello World!"[safe: 6...11] -> "World!"
    ///        "Hello World!"[safe: 21...110] -> nil
    ///
    /// - Parameter range: Range expression.
    subscript<R>(safe range: R) -> String? where R: RangeExpression, R.Bound == Int {
        let range = range.relative(to: Int.min..<Int.max)
        guard range.lowerBound >= 0,
            let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
            let upperIndex = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex) else {
            return nil
        }

        return String(self[lowerIndex..<upperIndex])
    }
    
    ///        "Hello World".slicing(from: 6, length: 5) -> "World"
    ///
    /// - Parameters:
    ///   - index: string index the slicing should start from.
    ///   - length: amount of characters to be sliced after given index.
    /// - Returns: sliced substring of length number of characters (if applicable) (example: "Hello World".slicing(from: 6, length: 5) -> "World").
    func slicing(from index: Int, length: Int) -> String? {
        guard length >= 0, index >= 0, index < count else { return nil }
        guard index.advanced(by: length) <= count else {
            return self[safe: index..<count]
        }
        guard length > 0 else { return "" }
        return self[safe: index..<index.advanced(by: length)]
    }
    ///
    ///        var str = "Hello World"
    ///        str.slice(at: 6)
    ///        print(str) // prints "World"
    ///
    /// - Parameter index: string index the slicing should start from.
    func slice(fro index: Int) -> String? {
        guard index < count else { return nil }
        return self[safe: index..<count]
    }
    
    ///        var str = "This is a very long sentence"
    ///        str.truncate(toLength: 14)
    ///        print(str) // prints "This is a very..."
    ///
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string (default is "...").
    @discardableResult
    mutating func truncate(toLength length: Int, trailing: String? = "...") -> String {
        guard length > 0 else { return self }
        if count > length {
            self = self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
        }
        return self
    }

}

// MARK: - 加密
public extension String{
    // base64 解密 加密
    ///
    ///        "SGVsbG8gV29ybGQh".base64Decoded = Optional("Hello World!")
    ///
    var base64Decode: String?{
        if let data = Data(base64Encoded: self,
                           options: .ignoreUnknownCharacters) {
            return String(data: data, encoding: .utf8)
        }
        
        let remainder = count % 4

        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }

        guard let data = Data(base64Encoded: self + padding,
                              options: .ignoreUnknownCharacters) else { return nil }

        return String(data: data, encoding: .utf8)
    }
    ///
    ///        "Hello World!".base64Encoded -> Optional("SGVsbG8gV29ybGQh")
    ///
    var base64Encoded: String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
}
