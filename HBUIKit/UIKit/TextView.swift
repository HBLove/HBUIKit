//
//  TextView.swift
//  HB
//
//  Created by 黄波 on 2023/11/3.
//

import UIKit
import Combine
open class TextView: UITextView, HBScrollView {
    var store: Set<AnyCancellable>?
    
    public func delegate(_ delegate: UITextViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    public func text(_ publisher: Published<String?>.Publisher) -> Self {
        publisher.receive(on: RunLoop.main).receive(on: RunLoop.main).assign(to: \.text, on: self).storeTo(self)
        return self
    }
    
    public func attributedText(_ publisher: Published<NSAttributedString?>.Publisher) -> Self {
        
        publisher.receive(on: RunLoop.main).assign(to: \.attributedText, on: self).storeTo(self)
        return self
    }
    
    public func text<Root>(to keyPath: ReferenceWritableKeyPath<Root, String?>, on object: Root) -> Self{
        publisher.assign(to: keyPath, on: object).storeTo(self)
        return self
    }
    
    public var publisher: AnyPublisher<String?, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification, object: self).map { note -> String? in
            guard let textView = note.object as? UITextView else {
                return nil
            }
            return textView.text
        }.eraseToAnyPublisher()
    }
    
    public func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    public func textColor(_ textColor: UIColor?) -> Self {
        self.textColor = textColor
        return self
    }
    public func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    public func selectedRange(_ selectedRange: NSRange) -> Self {
        self.selectedRange = selectedRange
        return self
    }
    public func isEditable(_ isEditable: Bool) -> Self {
        self.isEditable = isEditable
        return self
    }
    public func isSelectable(_ isSelectable: Bool) -> Self {
        self.isSelectable = isSelectable
        return self
    }
    public func dataDetectorTypes(_ dataDetectorTypes: UIDataDetectorTypes) -> Self {
        self.dataDetectorTypes = dataDetectorTypes
        return self
    }
    public func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> Self {
        self.allowsEditingTextAttributes = allowsEditingTextAttributes
        return self
    }
    public func typingAttributes(_ typingAttributes: [NSAttributedString.Key:Any]) -> Self {
        self.typingAttributes = typingAttributes
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
    public func textContainerInset(_ textContainerInset: UIEdgeInsets) -> Self {
        self.textContainerInset = textContainerInset
        return self
    }
    public func linkTextAttributes(_ linkTextAttributes: [NSAttributedString.Key:Any]) -> Self {
        self.linkTextAttributes = linkTextAttributes
        return self
    }
    public func usesStandardTextScaling(_ usesStandardTextScaling: Bool) -> Self {
        self.usesStandardTextScaling = usesStandardTextScaling
        return self
    }
    
    public func interactionState(_ interactionState: Any) -> Self {
        if #available(iOS 15.0, *) {
            self.interactionState = interactionState
        } 
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
