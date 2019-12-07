//
//  AppButton.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class AppButton: UIButton {
    
    var mainColor: UIColor = .lightGray{
        didSet{
            backgroundColor = mainColor
            layer.shadowColor = mainColor.cgColor
        }
    }
    
    var highlitedColor: UIColor?
    
    override open var isHighlighted: Bool {
        didSet {
            if let highlitedColor = self.highlitedColor{
                backgroundColor = isHighlighted ? highlitedColor : mainColor
                layer.shadowColor = isHighlighted ? highlitedColor.cgColor : mainColor.cgColor
            }else{
                backgroundColor = isHighlighted ? mainColor.darker() : mainColor
                layer.shadowColor = isHighlighted ? mainColor.darker()?.cgColor : mainColor.cgColor
            }
        }
    }
}
extension UIColor {

    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
