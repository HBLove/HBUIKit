//
//  VerificationRule.swift
//  HB
//
//  Created by 黄波 on 2023/12/5.
//

import Foundation

public struct Verification {
    public enum Rule {
        //"Hello 😀".containEmoji -> true
        case emoji(_:String)
            //"123abc".hasNumbers -> true "abcd".hasNumbers -> false
        case numbers(_:String)
            //"abc".isAlphabetic -> true "123abc".isAlphabetic -> false
        case alphabetic(_:String)
            //useful for passwords  "123abc".isAlphaNumeric -> true
            //"abc".isAlphaNumeric -> false
        case alphaNumeric(_:String)
            //"john@doe.com".isValidEmail -> true
        case email(_:String)
            //"https://google.com".isValidSchemedUrl -> true "google.com".isValidSchemedUrl -> false
        case url(_:String)
            ///"123".isNumeric -> true
            ///     "1.3".isNumeric -> true (en_US)
            ///     "1,3".isNumeric -> true (fr_FR)
            ///        "abc".isNumeric -> false
        case numeric(_:String)
            ///
            ///     "123".isDigits -> true
            ///     "1.3".isDigits -> false
            ///     "abc".isDigits -> false
        case digits(_:String)
            ///        "1".bool -> true
        case bool(_: String)
    }
}

extension Verification.Rule {
    public var valid: Bool{
        switch self {
        case .emoji(let text):
           return containEmoji(text)
        case .numbers(let text):
            //"123abc".hasNumbers -> true "abcd".hasNumbers -> false
           return text.rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        case .alphabetic(let text):
            ///        "abc".isAlphabetic -> true
            ///        "123abc".isAlphabetic -> false
            let hasLetters = text.rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
            let hasNumbers = text.rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
            return hasLetters && !hasNumbers
        case .alphaNumeric(let text):
            /// useful for passwords  "123abc".isAlphaNumeric -> true  "abc".isAlphaNumeric -> false
            let hasLetters = text.rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
            let hasNumbers = text.rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
            let comps = text.components(separatedBy: .alphanumerics)
            return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
        case .email(let text):
            // http://emailregex.com/ "john@doe.com".isValidEmail -> true
            let regex =
                "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
            return text.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
        case .url(let text):
            ///"https://google.com".isValidSchemedUrl -> true "google.com".isValidSchemedUrl -> false
            guard let url = URL(string: text) else { return false }
            return url.scheme != nil
        case .numeric(let text):
            ///        "123".isNumeric -> true
            ///     "1.3".isNumeric -> true (en_US)
            ///     "1,3".isNumeric -> true (fr_FR)
            ///        "abc".isNumeric -> false
            let scanner = Scanner(string: text)
            scanner.locale = NSLocale.current
            return scanner.scanDecimal() == nil && scanner.isAtEnd
        case .digits(let text):
            ///
            ///     "123".isDigits -> true
            ///     "1.3".isDigits -> false
            ///     "abc".isDigits -> false
            return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: text))
        case .bool(let text):
            ///        "1".bool -> true
            let selfLowercased = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            switch selfLowercased {
            case "true", "yes", "1":
                return true
            default:
                return false
            }
        }
    }

    
    
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    private func containEmoji(_ text: String) -> Bool{
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in text.unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x1F1E6...0x1F1FF, // Regional country flags
                 0x2600...0x26FF, // Misc symbols
                 0x2700...0x27BF, // Dingbats
                 0xE0020...0xE007F, // Tags
                 0xFE00...0xFE0F, // Variation Selectors
                 0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                 127_000...127_600, // Various asian characters
                 65024...65039, // Variation selector
                 9100...9300, // Misc items
                 8400...8447: // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
}
