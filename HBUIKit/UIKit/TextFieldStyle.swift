//
//  TextFieldStyle.swift
//  HB
//
//  Created by 黄波 on 2023/12/4.
//

import UIKit
public class TextFieldStyle: TextField {
    public enum Style {
        case bank
        case num(max: Int?, decimal: Int?)
        case phone
        case length(max: Int)
    }
    
    public let style: Style
    
    private var cumstomDelegate: TextFieldDelegate?
    
    public init(style: Style, delegate: TextFieldDelegate) {
        self.style = style
        super.init()
        self.cumstomDelegate = delegate
        self.delegate = self
        switch style {
        case .bank:
            keyboardType = .numberPad
        case .num(_, let decimal):
            keyboardType = decimal == nil ? .numberPad:.decimalPad
        case .phone:
            keyboardType = .numberPad
        case .length(let max):
            getEventMaganer().addAction(control: self, event: .editingChanged, onEventHandler: {[weak self] _ in
                self?.textdidChange(max: max)
            })
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 设置光标
    var selectedRange: NSRange{
        get {
            let beginning = self.beginningOfDocument
            let selectedRange = self.selectedTextRange
            let selectionStart = selectedRange!.start
            let selectionEnd = selectedRange!.end
            
            let location: NSInteger = self.offset(from: beginning, to: selectionStart)
            let length: NSInteger = self.offset(from: selectionStart, to: selectionEnd)
            return NSRange(location: location, length: length)
        }
        set{
            let beginning = self.beginningOfDocument
            guard let startPosition = self.position(from: beginning, offset: newValue.location) else { return}
            let endPosition = self.position(from: beginning, offset: newValue.location)!
            let selectionRange = self.textRange(from: startPosition, to: endPosition)
            self.selectedTextRange = selectionRange
        }
    }
    
}

// 长度限制
extension TextFieldStyle {
    private func textdidChange(max: Int){
        defer{
            cumstomDelegate?.textFieldDidChange?(self)
        }
        
        guard let toBeString = text, let lang = textInputMode?.primaryLanguage else {
            return
        }
        //简体中文输入，包括简体拼音，健体五笔，简体手写获取高亮部分
        if lang == "zh-Hans", let selectRange = markedTextRange{
            let position = position(from: selectRange.start, offset: 0)
            //没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if position == nil, toBeString.count > max {
                 text = toBeString.slicing(from: 0, length: max)
            }
        }else if toBeString.count > max{ //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            text = toBeString.slicing(from: 0, length: max)
        }

    }
}

@objc public protocol TextFieldDelegate: UITextFieldDelegate {
    @objc optional func textFieldDidChange(_ textField: UITextField)
    @objc optional func textFieldError(_ textFild:  UITextField)
}


extension TextFieldStyle: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return cumstomDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        cumstomDelegate?.textFieldDidBeginEditing?(textField)
    }

    // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return cumstomDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    public func textFieldDidEndEditing(_ textField: UITextField) {
        cumstomDelegate?.textFieldDidEndEditing?(textField)
    }

    // if implemented, called in place of textFieldDidEndEditing:
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        cumstomDelegate?.textFieldDidEndEditing?(textField, reason: reason)
    }

    
    // return NO to not change text
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result: Bool?
        switch style {
        case .phone:
            result = inputPhone(range: range, string: string)
        case let .num(max, decimal):
            result = inputNumber(range: range, string: string, max: max, decimal: decimal)
        case .bank:
            result = inputBank(range: range, string: string)
        default:
            break
        }
        if result == nil, let result = cumstomDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string){
            return result
        }
        return result ?? true
    }

    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        cumstomDelegate?.textFieldDidChangeSelection?(textField)
    }

    // called when clear button pressed. return NO to ignore (no notifications)
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        cumstomDelegate?.textFieldShouldClear?(textField) ?? true
    }
    
    // called when 'return' key pressed. return NO to ignore.
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        cumstomDelegate?.textFieldShouldReturn?(textField) ?? true
    }
    
    /**
     * @abstract Asks the delegate for the menu to be shown for the specified text range.
     *
     * @param textField                   The text field requesting the menu.
     * @param range                            The characters range for which the menu is presented for.
     * @param suggestedActions   The actions and commands that the system suggests.
     *
     * @return Return a UIMenu describing the desired menu hierarchy. Return @c nil to present the default system menu.
     */
    public func textField(_ textField: UITextField, editMenuForCharactersIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu? {
        if #available(iOS 16.0, *) {
           return cumstomDelegate?.textField?(textField, editMenuForCharactersIn: range, suggestedActions: suggestedActions)
        } else {
            // Fallback on earlier versions
            return nil
        }
    }

    
    /**
     * @abstract Called when the text field is about to present the edit menu.
     *
     * @param textField    The text field displaying the menu.
     * @param animator      Appearance animator. Add animations to this object to run them alongside the appearance transition.
     */
    
//    func textField(_ textField: UITextField, willPresentEditMenuWith animator: UIEditMenuInteractionAnimating) {
//
//    }

    
    /**
     * @abstract Called when the text field is about to dismiss the edit menu.
     *
     * @param textField    The text field displaying the menu.
     * @param animator      Dismissal animator. Add animations to this object to run them alongside the dismissal transition.
     */
//    @available(iOS 16.0, *)
//    optional func textField(_ textField: UITextField, willDismissEditMenuWith animator: UIEditMenuInteractionAnimating)
}

//MARK: 银行输入
private extension TextFieldStyle{
    func bankCardSpaceText(str: String){
        let tmpStr = str.replacingOccurrences(of: " ", with: "")
        let size = tmpStr.count/4
        var tmpStrArr = [String]()
        for i in 0..<size{
            let startRange = tmpStr.index(tmpStr.startIndex, offsetBy: 4*i)
            let endRange   = tmpStr.index(tmpStr.startIndex, offsetBy: 4*(i+1))
            let sub = String(tmpStr[startRange..<endRange])
            tmpStrArr.append(sub)
        }
       
        if tmpStr.count % 4>0 {
            let startRange = tmpStr.index(tmpStr.startIndex, offsetBy: 4*size)
            let endRange   = tmpStr.endIndex
            let sub = String(tmpStr[startRange..<endRange])
            tmpStrArr.append(sub)
        }
        self.text = tmpStrArr.joined(separator: " ")
    }
    
    //判断是否前面空格前面的位置
    func bankSpace(location: Int, isAdd: Bool) -> Bool {
        if isAdd,location == 4||location == 9||location == 14||location == 19 {
            return true
        }else if !isAdd,location == 5||location == 10||location == 15||location == 20{
            return true
        }
        return false
    }
   
    
    func inputBank(range: NSRange, string: String) -> Bool {
        guard let ran = text?.range(from: range), let textStr = text?.replacingCharacters(in: ran, with: string) else { return true}
       
        //删除数据
        if string.elementsEqual(""){
            bankCardSpaceText(str: textStr)
            var i = 0;
            if (bankSpace(location: range.location, isAdd: false)) {
                i = -1;
            }
            selectedRange =  NSRange(location: range.location + i, length: 0)
        }else if (textStr.count>=23) { // 最大时,只能输入19位+4个空格
            self.text = String(textStr.prefix(23))
        }else{
            // 是否添加了空格
            self.bankCardSpaceText(str: textStr)
            var i = 1
            if bankSpace(location: range.location, isAdd: true) {
                i = +1
            }
            selectedRange =  NSRange(location: range.location + i, length: 0)
        }
        return false;
    }
}

//MARK: 手机号输入
extension TextFieldStyle{
    func phoneSpaceText(str: String){
        let tmpStr = str.replacingOccurrences(of: " ", with: "")
        switch tmpStr.count {
        case 0,1,2,3:
            text = tmpStr
        case 4,5,6,7:
            text = tmpStr.prefix(3) + " " + tmpStr.suffix(tmpStr.count - 3)
        case 8,9,10,11:
            let mid = tmpStr.slicing(from: 3, length: 4) ?? ""
            text = tmpStr.prefix(3) + " " + mid + " " + tmpStr.suffix(tmpStr.count - 7)
        default: break
        }
     
    }
    
    //判断是否前面空格前面的位置
    func phoneSpace(location: Int, isAdd: Bool) -> Bool {
        if isAdd,location == 3||location == 8{
            return true
        }else if !isAdd,location == 4||location == 9{
            return true
        }
        return false
    }
    
    
    func inputPhone(range: NSRange, string: String) -> Bool{
        guard let ran = text?.range(from: range), let textStr = text?.replacingCharacters(in: ran, with: string) else { return true}
        //删除数据
        if string == ""{
            phoneSpaceText(str: textStr)
            var i = 0
            if (phoneSpace(location: range.location, isAdd: false)) { i = -1}
            selectedRange =  NSRange(location: range.location + i, length: 0)
        }else if (textStr.count>=13) { // 最大时,只能输入19位+4个空格
            self.text = String(textStr.prefix(13))
        }else{//添加
            // 是否添加了空格
            phoneSpaceText(str: textStr)
            var i = 1
            if phoneSpace(location: range.location, isAdd: true) {i = +2}
            selectedRange =  NSRange(location: range.location + i, length: 0)
        }
        return false;
    }
}



// MARK: - 数字输入
extension TextFieldStyle{
    func inputNumber(range: NSRange, string: String, max: Int?, decimal: Int?) -> Bool {
        if string.isEmpty  {
            return true
        }else if string == " "{
            return false
        }
        
        if let text = text, let decimal = decimal, let ran = text.range(of: "."){
            let range = text.nsRange(from: ran)
            if range.location != NSNotFound && (text.count - range.length - range.location >= decimal || string.contains(".")){
                return false
            }
        }
        guard let ran = text?.range(from: range), let textStr = text?.replacingCharacters(in: ran, with: string) else { return true}
        if let max = max {
            if  let decimal = decimal, decimal > 0, let value = textStr.float(), value > Float(max){
                cumstomDelegate?.textFieldError?(self)
                return false
            }else if decimal == nil, let value = textStr.int, value > max{
                cumstomDelegate?.textFieldError?(self)
                return false
            }
        }
        let single = string.prefix(1)
        if (single >= "0" && single <= "9") || single == "." {
            if text?.count == 0 && (single == "." || single == "0") {
                text = "0."
                return false
            }
            return true
        }else{
            return false
        }
    }
}
