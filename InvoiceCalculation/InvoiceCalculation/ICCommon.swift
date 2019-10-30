//
//  ICCommon.swift
//  InvoiceCalculation
//
//  Created by Hehuimin on 2019/9/29.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import UIKit

struct ICCommon {
    static var screenWidth: CGFloat = UIScreen.main.bounds.width
    static var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    static func localizable(_ key: String) -> String {
        return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    }
    
//    static func matchesNumberPoint(_ text: String) {
//        let pattern = "^[0-9,.]*$"
//
//        let rex = try? NSRegularExpression(pattern: pattern, options: [])
//        let matches = rex?.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
//
//    }
}

struct ICFont {
    static var system14: UIFont = UIFont.systemFont(ofSize: 14.0)
    static var system16: UIFont = UIFont.systemFont(ofSize: 16.0)
    static var system12: UIFont = UIFont.systemFont(ofSize: 12.0)
}

struct ICColor {
    static var cWhite: UIColor = UIColor.white
    static var cLightGray: UIColor = UIColor.lightGray
    static var cBlue: UIColor = UIColor.blue
    static var cF1: UIColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
}
