//
//  CustomSlider.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/12/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: bounds.midY)
        return CGRect(origin: point, size: CGSize(width: bounds.width, height: 4))
    }

}
