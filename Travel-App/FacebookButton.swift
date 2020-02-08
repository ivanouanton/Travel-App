//
//  FacebookButton.swift
//  Travel-App
//
//  Created by Антон Иванов on 2/6/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import FBSDKLoginKit

class FacebookButton: FBLoginButton {

    override func updateConstraints() {
        // deactivate height constraints added by the facebook sdk (we'll force our own instrinsic height)
        for contraint in constraints {
            if contraint.firstAttribute == .height, contraint.constant < 40 {
                // deactivate this constraint
                contraint.isActive = false
            }
        }
        super.updateConstraints()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 40)
    }

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let logoSize: CGFloat = 24.0
        let centerY = contentRect.midY
        let y: CGFloat = centerY - (logoSize / 2.0)
        return CGRect(x: y, y: y, width: logoSize, height: logoSize)
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if isHidden || bounds.isEmpty {
            return .zero
        }

        let imageRect = self.imageRect(forContentRect: contentRect)
        let titleX = imageRect.maxX
        let titleRect = CGRect(x: titleX, y: 0, width: contentRect.width - titleX - titleX, height: contentRect.height)
        return titleRect
    }

}
