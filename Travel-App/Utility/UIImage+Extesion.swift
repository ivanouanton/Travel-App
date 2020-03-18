//
//  UIImage+Extesion.swift
//  Travel-App
//
//  Created by Антон Иванов on 3/18/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

extension UIImage {
    func scaledToSize(newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
