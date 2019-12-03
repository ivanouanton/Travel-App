//
//  Label.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/30/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

final class Label: UILabel {
    
    var padding: UIEdgeInsets?
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: padding ?? insets))
    }
}
