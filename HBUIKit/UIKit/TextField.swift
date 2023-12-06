//
//  TextField.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
// _clearButton
public class TextField: UITextField, SwiftUIKitControl {
    public convenience init(_ text: String) {
        self.init()
        self.text = text
    }
    
    public func text<Root>(to keyPath: ReferenceWritableKeyPath<Root, String?>, on object: Root, store: inout Set<AnyCancellable>) -> Self{
        publisher.assign(to: keyPath, on: object).store(in: &store)
        return self
    }
    
    public func text(_ publisher: Published<String?>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.text, on: self).store(in: &store)
        return self
    }
    
    public func attributedText(_ publisher: Published<NSAttributedString?>.Publisher, store: inout Set<AnyCancellable>) -> Self {
        publisher.receive(on: RunLoop.main).assign(to: \.attributedText, on: self).store(in: &store)
        return self
    }
    
    public var publisher: AnyPublisher<String?, Never> {
        publisher(events: .editingChanged).map { $0.text }.eraseToAnyPublisher()
    }
   
    public func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    public func attributedText(_ text: NSAttributedString?) -> Self {
        self.attributedText = text
        return self
    }
    
    public func textColor(_ textColor: UIColor?) -> Self {
        self.textColor = textColor
        return self
    }
    public func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    public func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    public func borderStyle(_ borderStyle: TextField.BorderStyle) -> Self {
        self.borderStyle = borderStyle
        return self
    }
    public func defaultTextAttributes(_ defaultTextAttributes: [NSAttributedString.Key : Any]) -> Self {
        self.defaultTextAttributes = defaultTextAttributes
        return self
    }
    public func placeholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }

    public func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> Self {
        self.attributedPlaceholder = attributedPlaceholder
        return self
    }

    public func clearsOnBeginEditing(_ clearsOnBeginEditing: Bool) -> Self {
        self.clearsOnBeginEditing = clearsOnBeginEditing
        return self
    }
    public func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    public func minimumFontSize(_ minimumFontSize: CGFloat) -> Self {
        self.minimumFontSize = minimumFontSize
        return self
    }
    public func delegate(_ delegate: UITextFieldDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    public func background(_ background: UIImage?) -> Self {
        self.background = background
        return self
    }
    public func disabledBackground(_ disabledBackground: UIImage?) -> Self {
        self.disabledBackground = disabledBackground
        return self
    }
    public func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> Self {
        self.allowsEditingTextAttributes = allowsEditingTextAttributes
        return self
    }
    public func typingAttributes(_ typingAttributes: [NSAttributedString.Key : Any]) -> Self {
        self.typingAttributes = typingAttributes
        return self
    }
    public func clearButtonMode(_ clearButtonMode: TextField.ViewMode) -> Self {
        self.clearButtonMode = clearButtonMode
        return self
    }
    public func leftView(_ leftView: UIView?) -> Self {
        self.leftView = leftView
        return self
    }
    public func leftViewMode(_ leftViewMode: TextField.ViewMode) -> Self {
        self.leftViewMode = leftViewMode
        return self
    }
    public func rightView(_ rightView: UIView?) -> Self {
        self.rightView = rightView
        return self
    }
    public func rightViewMode(_ rightViewMode: TextField.ViewMode) -> Self {
        self.rightViewMode = rightViewMode
        return self
    }
    public func inputView(_ inputView: UIView?) -> Self {
        self.inputView = inputView
        return self
    }
    public func inputAccessoryView(_ inputAccessoryView: UIView?) -> Self {
        self.inputAccessoryView = inputAccessoryView
        return self
    }
    public func clearsOnInsertion(_ clearsOnInsertion: Bool) -> Self {
        self.clearsOnInsertion = clearsOnInsertion
        return self
    }
    
    public func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = autocapitalizationType
        return self
    }
    public func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> Self {
        self.autocorrectionType = autocorrectionType
        return self
    }
    public func spellCheckingType(_ spellCheckingType: UITextSpellCheckingType) -> Self {
        self.spellCheckingType = spellCheckingType
        return self
    }
    public func smartQuotesType(_ smartQuotesType: UITextSmartQuotesType) -> Self {
        self.smartQuotesType = smartQuotesType
        return self
    }
    public func smartDashesType(_ smartDashesType: UITextSmartDashesType) -> Self {
        self.smartDashesType = smartDashesType
        return self
    }
    public func smartInsertDeleteType(_ smartInsertDeleteType: UITextSmartInsertDeleteType) -> Self {
        self.smartInsertDeleteType = smartInsertDeleteType
        return self
    }
    public func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }
    public func keyboardAppearance(_ keyboardAppearance: UIKeyboardAppearance) -> Self {
        self.keyboardAppearance = keyboardAppearance
        return self
    }
    public func returnKeyType(_ returnKeyType: UIReturnKeyType) -> Self {
        self.returnKeyType = returnKeyType
        return self
    }
    public func enablesReturnKeyAutomatically(_ enablesReturnKeyAutomatically: Bool) -> Self {
        self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        return self
    }
    public func isSecureTextEntry(_ isSecureTextEntry: Bool) -> Self {
        self.isSecureTextEntry = isSecureTextEntry
        return self
    }
    public func textContentType(_ textContentType: UITextContentType!) -> Self {
        self.textContentType = textContentType
        return self
    }
    public func passwordRules(_ passwordRules: UITextInputPasswordRules?) -> Self {
        self.passwordRules = passwordRules
        return self
    }
}
