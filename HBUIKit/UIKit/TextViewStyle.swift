//
//  TextViewStyle.swift
//  HB
//
//  Created by 黄波 on 2023/12/4.
//

import Foundation
import UIKit
@objc public protocol TextViewDelegate: UITextViewDelegate {
    @objc optional func textViewReturn(_ textView: UITextView)
    @objc optional func textViewDidChange(_ textView: UITextView)
    @objc optional func textViewTap(_ textView: UITextView, index: Int)
}
public class TextViewStyle: TextView, UITextViewDelegate{
    public enum Style {
        case tap
        case placeholder
    }
    public let style: Style
    
    public init(style: Style) {
        self.style = style
        super.init()
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        enablesReturnKeyAutomatically = true
        layoutManager.allowsNonContiguousLayout = false
        isExclusiveTouch  = true
        returnKeyType = .done
        scrollsToTop = false
        self.delegate = self
        keyboardAppearance = .dark
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        guard style == .tap else{return}
        isScrollEnabled = false
        isEditable = false
        linkTextAttributes = [:]
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var canBecomeFocused: Bool{
        return style != .tap
    }
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return style != .tap
    }
    
    private lazy var placeholderLab = UILabel()
    private var limitNum: Int?
    public weak var customDelegate: TextViewDelegate?
    
    public var isHiddenPlaceholder: Bool = false{
        didSet{
            placeholderLab.isHidden = isHiddenPlaceholder
        }
    }
    // placeholder
    public func setup(placeholder: String, placeholderColor: UIColor, maxCount: Int? = nil){
        guard style == .placeholder else {return}
        placeholderLab.removeFromSuperview()
        placeholderLab.text = placeholder
        placeholderLab.textColor = placeholderColor
        addSubview(placeholderLab)
        placeholderLab.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderLab.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.textContainerInset.left + 2),
            placeholderLab.topAnchor.constraint(equalTo: self.topAnchor, constant: self.textContainerInset.top - 1)
        ])
        limitNum = maxCount
    }
    
    // 选择
    public func setText(text: String, selectText: [String], selectColor: UIColor){
    
        let att = NSMutableAttributedString(string: text)
        att.addAttribute(.font, value: font!, range: .init(location: 0, length: text.count))
        att.addAttribute(.foregroundColor, value: textColor!, range: .init(location: 0, length: text.count))
        let paragraph = NSMutableParagraphStyle()
        
        paragraph.lineSpacing = 2
//        paragraph.maximumLineHeight = textFont.lineHeight
        paragraph.paragraphSpacingBefore = 0
        
        att.addAttribute(.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: text.count))
        for (i,item) in selectText.enumerated() {
            let ran = (text as NSString).range(of: item)
            guard ran.location != NSNotFound else{continue}
            att.addAttribute(.foregroundColor, value: selectColor, range: ran)
            
            att.addAttribute(.link, value: "https://\(i)" , range: ran)
        }
        self.attributedText = att
    }
    

    //光标的大小位置
    open override func caretRect(for position: UITextPosition) -> CGRect {
        var rece = super.caretRect(for: position)
        rece.size.height = (self.font?.lineHeight ?? 0) + 3;
        rece.origin.y -= 2
        return rece;
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else{return true}
        resignFirstResponder()
        customDelegate?.textViewReturn?(self)
        return false
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLab.isHidden = textView.text.count > 0
        if let limitNum = limitNum, self.text.count - 5 > limitNum {
            //获得已输出字数与正输入字母数
            let selectRange = self.markedTextRange
            //获取高亮部分 － 如果有联想词则解包成功
            if let ran = selectRange, let _ = self.position(from: ran.start, offset: 0){
                return
            }
            if self.text.count > limitNum {
                self.text = String(self.text.prefix(limitNum))
            }
        }
        customDelegate?.textViewDidChange?(self)
    }
    
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        guard let str = URL.absoluteString.components(separatedBy: "//").last, let num = Int(str) else{
            return true
        }
        customDelegate?.textViewTap?(self, index: num)
        return false
    }
}
