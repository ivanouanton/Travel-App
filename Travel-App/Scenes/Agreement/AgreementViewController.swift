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
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var verticalSlider: CustomSlider!{
        didSet{
            verticalSlider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            verticalSlider.setThumbImage(UIImage(named: "thimb"), for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func sliderValueDidChanged(_ sender: UISlider) {
        
        let scrollOffSet = CGFloat(sender.value) * (scrollView.contentSize.height - scrollView.frame.height)
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffSet), animated: true)
    }
}

extension AgreementViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let sliderValue = scrollView.contentOffset.y/(scrollView.contentSize.height - scrollView.frame.height)
        print(sliderValue)

        verticalSlider.value = Float(sliderValue)
    }
}
