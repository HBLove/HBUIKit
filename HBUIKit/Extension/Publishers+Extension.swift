//
//  File.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/12/4.
//

import Combine
import UIKit
/// 自定义
public extension Publishers {
    /// 1、自定义 Subscription
    /// 定义输入类型为UIControl，错误类型为Never
    private final class UIControlSubscription<S:Subscriber, Control: UIControl> : Subscription where S.Input == Control, S.Failure == Never {
        private var subscriber: S?
        private var control: Control
        private var events: Control.Event
        /// Step 1 ： 初始化
        init(subscriber: S?, control: Control, events: Control.Event) {
            self.subscriber = subscriber
            self.control = control
            self.events = events
            configControl()
        }
        deinit {
            print("UIControlSubscription deinit~~~")
        }

        /// Step 2 ： 关联 与 控制
        func configControl() {
            self.control.addTarget(self, action: #selector(eventHandler), for: self.events)
        }
        
        @objc func eventHandler() {
            // 忽略返回值
            _ = self.subscriber?.receive(self.control)
        }
        
        func request(_ demand: Subscribers.Demand) {
            
        }
        
        /// Step 3 ： 销毁
        func cancel() {
            // 销毁订阅者
            subscriber = nil
        }

    }
    
    /// 2、自定义 Publisher
    struct UIControlPublisher<Control: UIControl> : Publisher {
        public typealias Output = Control
        public typealias Failure = Never
        
        private var control: Control
        private var events: Control.Event
        /// Step 1 ： 初始化
        init(control: Control, events: Control.Event) {
            self.control = control
            self.events = events
        }
        
        /// Step 2 ：通过 Subscription 将 订阅者Subscriber 连接到 发布者Publisher
        public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Control == S.Input {
            let subscription = UIControlSubscription(subscriber: subscriber, control: self.control, events: self.events)
            subscriber.receive(subscription: subscription)
        }
    }
}

