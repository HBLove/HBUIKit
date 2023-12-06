//
//  CABasicAnimation+Extension.swift
//  SwiftUIKit
//
//  Created by 黄波 on 2023/12/4.
//

import Foundation
import QuartzCore
public extension CABasicAnimation{
    enum Key: String {
        case position = "position" //移动动画position，CGPoint
        case aphla = "opacity"      //透明度 0-1
        case bounds = "bounds"      //变大与位置 bounds
        case size = "bounds.size"   //由小变大
        case bgColor = "backgroundColor" //背景颜色
        case cornerRadius = "cornerRadius"  //渐变圆角
        case borderWidth = "borderWidth"//改变边框border的大小(图形周围边框，border默认为黑色
        case contents = "contents" //改变layer内容(图片)，注意如果想要达到改变内容的动画效果，首先在运行动画之前定义好layer的contents contents
        case scale = "transform.scale" //缩放、放大
        case rotationX = "transform.rotation.x" //旋转动画(翻转，沿着X轴)
        case rotationY = "transform.rotation.y" //旋转动画(翻转，沿着y轴)
        case rotationZ = "transform.rotation.z" //旋转动画(翻转，沿着x轴)
        case translationX = "transform.translation.x"//横向移动（沿着X轴
        case translationY = "transform.translation.y"//横向移动（沿着X轴
        case translationZ = "transform.translation.z"//横向移动（沿着X轴
        case strokeStart = "strokeStart" //抹掉线
        case strokeEnd = "strokeEnd" //划线
    }
    
    convenience init(key: Key){
        self.init(keyPath: key.rawValue)
    }
}
