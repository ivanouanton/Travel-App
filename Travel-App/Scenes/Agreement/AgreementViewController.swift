//
//  AgreementViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/28/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class AgreementViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var verticalSlider: CustomSlider!{
        didSet{
            verticalSlider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            verticalSlider.setThumbImage(UIImage(named: "thimb"), for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
