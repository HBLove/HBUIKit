//
//  KeyboardState.swift
//  HB
//
//  Created by 黄波 on 2023/12/5.
//

import UIKit
import Combine

final  public class Keyboard: NSObject {
    @Published public private(set) var state: State = .default
    public dynamic private(set)  var isShown: Bool = false
    
    public var isShowing: Bool {
        state.height.map({ $0 != 0 }) ?? false
    }
    
    public var isActive: Bool {
        isShowing || isShown
    }
    
    private var keyboardWillChangeFrameSubscription: AnyCancellable?
    private var keyboardDidChangeFrameSubscription: AnyCancellable?
    private var keyboardWillShowSubscription: AnyCancellable?
    private var keyboardDidShowSubscription: AnyCancellable?
    private var keyboardWillHideSubscription: AnyCancellable?
    private var keyboardDidHideSubscription: AnyCancellable?
    
    public convenience init(notificationCenter: NotificationCenter = .default) {
        self.init()
        #if os(iOS) || targetEnvironment(macCatalyst)
        self.keyboardWillChangeFrameSubscription = notificationCenter
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap({ Keyboard.State(notification: $0) })
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self)
        
        self.keyboardDidChangeFrameSubscription = notificationCenter
            .publisher(for: UIResponder.keyboardDidChangeFrameNotification)
            .compactMap({ Keyboard.State(notification: $0) })
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self)
        
//        self.keyboardWillShowSubscription = notificationCenter
//            .publisher(for: UIResponder.keyboardWillShowNotification)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: { _ in self.objectWillChange.send() })
        
        self.keyboardDidShowSubscription = notificationCenter
            .publisher(for: UIResponder.keyboardDidShowNotification)
            .compactMap({ Keyboard.State(notification: $0) })
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { _ in self.isShown = true })
            .assign(to: \.state, on: self)
        
//        self.keyboardWillHideSubscription = notificationCenter
//            .publisher(for: UIResponder.keyboardWillHideNotification)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: { _ in self.objectWillChange.send() })
        
        self.keyboardDidHideSubscription = notificationCenter
            .publisher(for: UIResponder.keyboardDidHideNotification)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { _ in self.isShown = false })
            .map({ _ in .init() })
            .assign(to: \.state, on: self)
        #endif
    }
    
    /// Dismiss the software keyboard presented on-screen.
    public func dismiss() {
//        if isShowing {
//            HBApp.firstKeyWindow?.endEditing(true)
//        }
    }
    
    /// Dismiss the software keyboard presented on-screen.
    public class func dismiss() {
//        if HBKeyboard.main.isShowing {
//            HBApp.firstKeyWindow?.endEditing(true)
//        }
    }
}

extension Keyboard {
    public struct State {
        public static let `default` = State()
        
        public let animationDuration: TimeInterval
        public let animationCurve: UInt?
        public let keyboardFrame: CGRect?
        public let height: CGFloat?
        
        init() {
            self.animationDuration = 0.25
            self.animationCurve = 0
            self.keyboardFrame = nil
            self.height = nil
        }
        
        init?(notification: Notification) {
            #if os(iOS) || targetEnvironment(macCatalyst)
            guard
                let userInfo = notification.userInfo,
                let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
                let animationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
            else {
                return nil
            }
            
            self.animationDuration = animationDuration
            self.animationCurve = animationCurve
            
            if let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                self.keyboardFrame = keyboardFrame
//                print(keyboardFrame)
                if keyboardFrame.origin.y == HBApp.statusHeight {
                    self.height = 0
                } else {
                    self.height = keyboardFrame.height
                }
            } else {
                self.keyboardFrame = nil
                self.height = nil
            }
            #else
            return nil
            #endif
        }
    }
}
