//
//  AttributedStringHelper.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/30/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit
import Foundation

class AttributedStringHelper {

    static func bulletedList(strings:[String], textColor:UIColor, font:UIFont, bulletColor: UIColor, bulletSize: CGFloat) -> NSAttributedString {
        let textAttributesDictionary = [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor:textColor]

        let bulletAttributesDictionary = [NSAttributedString.Key.font : font.withSize(bulletSize), NSAttributedString.Key.foregroundColor:bulletColor]
        let fullAttributedString = NSMutableAttributedString.init()

        for string: String in strings
        {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
            let paragraphStyle = createParagraphAttribute()

            attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            attributedString.addAttributes(textAttributesDictionary, range: NSMakeRange(0, attributedString.length))

            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: bulletPoint)

            attributedString.addAttributes(bulletAttributesDictionary, range: rangeForBullet)
            fullAttributedString.append(attributedString)
        }
        return fullAttributedString
    }

    static func createParagraphAttribute() -> NSParagraphStyle {

        var paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15)]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.lineSpacing = 15
        paragraphStyle.headIndent = 10
        return paragraphStyle
    }
}
