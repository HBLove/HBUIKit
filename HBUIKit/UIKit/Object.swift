//
//  HBBase.swift
//  HB
//
//  Created by 黄波 on 2023/11/22.
//

import UIKit
@resultBuilder
public struct ViewClosure {
    public typealias Expression = UIView
    public typealias Component = [UIView]
    public static func buildExpression(_ expression: Expression) -> Component {
        return [expression]
    }
    public static func buildBlock(_ components: Component...) -> Component {
        return components.flatMap { $0 }
    }
    public static func buildBlock(_ components: UIView...) -> Component {
        return components.map { $0 }
    }
    public static func buildOptional(_ component: Component?) -> Component {
        return component ?? []
    }
    public static func buildEither(first component: Component) -> Component {
        return component
    }
    public static func buildEither(second component: Component) -> Component {
        return component
    }
    public static func buildArray(_ components: [Component]) -> Component {
        Array(components.joined())
    }
}

// MARK: 事件
open class ViewEventMaganer {
    
    private var eventDictionary: [Target] = []
    
    func addAction(control: UIControl, event: UIControl.Event, onEventHandler: @escaping (Any?) -> Void) {
        let target = Target(eventHandler: onEventHandler)
        eventDictionary.append(target)
        control.addTarget(target, action: #selector(ViewEventMaganer.Target.action), for: event)
    }
    
    func addGesture(gesture: UIGestureRecognizer, onEventHandler: @escaping (Any?) -> Void) {
        let target = Target(eventHandler: onEventHandler)
        eventDictionary.append(target)
        gesture.addTarget(target, action:  #selector(ViewEventMaganer.Target.action))
    }
    
    private class Target {
        let eventHandler: (Any?) -> Void
        @objc func action(_ sender: Any?){
            eventHandler(sender)
        }
        
        init(eventHandler: @escaping (Any?) -> Void) {
            self.eventHandler = eventHandler
        }
    }
}

public struct ViewLayout {
    public enum Alignment: CaseIterable {
        case center
        case leading
        case trailing
        case top
        case bottom
        case topLeading
        case topTrailing
        case bottomLeadingn
        case bottomTrailing
    }
}

extension ViewLayout {
    static func frame(view: UIView, in contaier: UIView, alignment: Alignment, isBack: Bool = false, isContain: Bool = true) {
        if isBack {
            contaier.insertSubview(view, at: 0)
        } else {
            contaier.addSubview(view)
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        contaier.translatesAutoresizingMaskIntoConstraints = false
    
        switch alignment {
        case .center:
            view.centerXAnchor.constraint(equalTo: contaier.centerXAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: contaier.centerYAnchor).isActive = true
            guard isContain else { return }
            view.leadingAnchor.constraint(greaterThanOrEqualTo: contaier.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(lessThanOrEqualTo: contaier.trailingAnchor).isActive = true
            view.topAnchor.constraint(greaterThanOrEqualTo: contaier.topAnchor, constant: 0).isActive = true
            view.bottomAnchor.constraint(lessThanOrEqualTo: contaier.bottomAnchor).isActive = true
            
        case .leading:
            view.leadingAnchor.constraint(equalTo: contaier.leadingAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: contaier.centerYAnchor).isActive = true
            
            guard isContain else { return }
            view.trailingAnchor.constraint(lessThanOrEqualTo: contaier.trailingAnchor).isActive = true
            view.topAnchor.constraint(greaterThanOrEqualTo: contaier.topAnchor, constant: 0).isActive = true
            view.bottomAnchor.constraint(lessThanOrEqualTo: contaier.bottomAnchor).isActive = true
        case .trailing:
            view.trailingAnchor.constraint(equalTo: contaier.trailingAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: contaier.centerYAnchor).isActive = true
            
            guard isContain else { return }
            view.leadingAnchor.constraint(greaterThanOrEqualTo: contaier.leadingAnchor, constant: 0).isActive = true
            view.topAnchor.constraint(greaterThanOrEqualTo: contaier.topAnchor, constant: 0).isActive = true
            view.bottomAnchor.constraint(lessThanOrEqualTo: contaier.bottomAnchor).isActive = true
        case .top:
            view.topAnchor.constraint(equalTo: contaier.topAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: contaier.centerXAnchor).isActive = true
            
            guard isContain else { return }
            view.leadingAnchor.constraint(greaterThanOrEqualTo: contaier.leadingAnchor, constant: 0).isActive = true
            view.trailingAnchor.constraint(lessThanOrEqualTo: contaier.trailingAnchor).isActive = true
            view.bottomAnchor.constraint(lessThanOrEqualTo: contaier.bottomAnchor).isActive = true
        case .bottom:
            view.bottomAnchor.constraint(equalTo: contaier.bottomAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: contaier.centerXAnchor).isActive = true
            
            guard isContain else { return }
            view.leadingAnchor.constraint(greaterThanOrEqualTo: contaier.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(lessThanOrEqualTo: contaier.trailingAnchor).isActive = true
            view.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor).isActive = true
        case .topLeading:
            view.topAnchor.constraint(equalTo: contaier.topAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: contaier.leadingAnchor).isActive = true
            
            guard isContain else { return }
            view.trailingAnchor.constraint(lessThanOrEqualTo: contaier.trailingAnchor).isActive = true
            view.bottomAnchor.constraint(lessThanOrEqualTo: contaier.bottomAnchor).isActive = true
        case .topTrailing:
            view.topAnchor.constraint(equalTo: contaier.topAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: contaier.trailingAnchor).isActive = true
            
            guard isContain else { return }
            view.leadingAnchor.constraint(greaterThanOrEqualTo: contaier.leadingAnchor, constant: 0).isActive = true
            view.bottomAnchor.constraint(lessThanOrEqualTo: contaier.bottomAnchor).isActive = true
        case .bottomLeadingn:
            view.bottomAnchor.constraint(equalTo: contaier.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: contaier.leadingAnchor).isActive = true
            
            guard isContain else { return }
            view.trailingAnchor.constraint(lessThanOrEqualTo: contaier.trailingAnchor).isActive = true
            view.topAnchor.constraint(greaterThanOrEqualTo: contaier.topAnchor).isActive = true
        case .bottomTrailing:
            view.bottomAnchor.constraint(equalTo: contaier.bottomAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: contaier.trailingAnchor).isActive = true
            
            guard isContain else { return }
            view.leadingAnchor.constraint(greaterThanOrEqualTo: contaier.leadingAnchor, constant: 0).isActive = true
            view.topAnchor.constraint(greaterThanOrEqualTo: contaier.topAnchor).isActive = true
        }
    }
    
    static func padding(_ padding: UIEdgeInsets, view: UIView, in contaier: UIView) {
        contaier.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        contaier.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contaier.leadingAnchor, constant: padding.left),
            view.topAnchor.constraint(equalTo: contaier.topAnchor, constant: padding.top),
            view.trailingAnchor.constraint(equalTo: contaier.trailingAnchor, constant: -padding.right),
            view.bottomAnchor.constraint(equalTo: contaier.bottomAnchor, constant: -padding.bottom)
        ])
    }
    
    static func offset(x: CGFloat, y: CGFloat, view: UIView, in contaier: UIView) {
        contaier.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        contaier.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: contaier.centerXAnchor, constant: x),
            view.centerYAnchor.constraint(equalTo: contaier.centerYAnchor, constant: y),
            view.widthAnchor.constraint(equalTo: contaier.widthAnchor),
            view.heightAnchor.constraint(equalTo: contaier.heightAnchor)
        ])
    }
}
