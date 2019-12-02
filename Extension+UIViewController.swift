//
//  Extension+UIViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/30/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

extension UIViewController {

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
