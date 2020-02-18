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
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var verticalSlider: CustomSlider!{
        didSet{
            verticalSlider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            verticalSlider.setThumbImage(UIImage(named: "thimb"), for: .normal)
        }
    }
    
    weak var delegate: AgreementDelegate?
    
    var state: AgreementType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.attributedText = state?.getAttributedString()
        title = state?.getTitle()
        //        navigationItem.hidesBackButton = true

        navigationController?.navigationBar.barTintColor = UIColor(named: "heavy")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "white")!]
    }
    
    @IBAction func sliderValueDidChanged(_ sender: UISlider) {
        let scrollOffSet = CGFloat(sender.value) * (scrollView.contentSize.height - scrollView.frame.height)
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffSet), animated: true)
    }
    @IBAction func didPressedAccept(_ sender: Any) {
        delegate?.agreementAccept(state!, accept: true)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func didPressedDeciline(_ sender: Any) {
        delegate?.agreementAccept(state!, accept: false)
        navigationController?.popViewController(animated: true)
    }
}

extension AgreementViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sliderValue = scrollView.contentOffset.y/(scrollView.contentSize.height - scrollView.frame.height)

        verticalSlider.value = Float(sliderValue)
    }
}
