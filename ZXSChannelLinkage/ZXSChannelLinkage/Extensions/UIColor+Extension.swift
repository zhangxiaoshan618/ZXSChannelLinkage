//
//  AppDelegate.swift
//  startvhelper
//
//  Created by 张晓珊 on 15/11/9.
//  Copyright © 2015年 张晓珊. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 生成随机颜色
    class func randomColor() -> UIColor {
        return UIColor(red: randomValue(), green: randomValue(), blue: randomValue(), alpha: 1.0)
    }
    
    /// 十六进制RGB颜色转换（RGB#D45B26）
    ///
    /// - parameter colorString: RGB16进制字符串
    /// - parameter alpha:       透明度（默认为1.0）
    ///
    /// - returns: 对应的颜色
    class func colorWithHexString(colorString: String, alpha: CGFloat = 1.0) -> UIColor {
        
        var cString: NSString = colorString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        // cString should be 6 or 8 characters
        if cString.length < 6 {
            return UIColor.clearColor()
        }
        
        // strip 0X if it appears
        if cString.hasPrefix("0X") {
            cString = cString.substringFromIndex(2)
        }
        if cString.hasPrefix("#") {
            cString = cString.substringFromIndex(1)
        }
        if cString.length != 6 {
            return UIColor.clearColor()
        }
        
        // Separate into r, g, b substrings
        var range = NSRange.init(location: 0, length: 2)
        
        //r
        let rString = cString.substringWithRange(range)
        // g
        range.location = 2
        let gString = cString.substringWithRange(range)
        // b
        range.location = 4
        let bString = cString.substringWithRange(range)
        
        // Scan values
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        return UIColor(red: (CGFloat(r) / 255.0), green: (CGFloat(g) / 255.0), blue: (CGFloat(b) / 255.0), alpha: alpha)
    }
    
    /// 返回随机数
    private class func randomValue() -> CGFloat {
        // 为什么？ 255，0~254，256 0~255
        return CGFloat(arc4random_uniform(256)) / 255.0
    }
}
