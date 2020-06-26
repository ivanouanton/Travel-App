//
//  StoryboardExampleViewController.swift
//  SwiftyOnboardExample
//
//  Created by Jay on 3/27/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit
import SwiftyOnboard

class StoryboardExampleViewController: UIViewController {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var swiftyOnboard: SwiftyOnboard!
    
    let infoImages = ["", "create-tour"]
    let infoTitle = ["City Introduction", "Plot a Tour"]
    let infoDescr = ["Find out the essential background information before exploring the city", "Select your interests, duration and budget, and Urbs will plot you a customised tour"]

    override func viewDidLoad() {
        super.viewDidLoad()
        swiftyOnboard.style = .dark
        swiftyOnboard.delegate = self
        swiftyOnboard.dataSource = self
        swiftyOnboard.backgroundColor = UIColor.white
    }
    
    @objc func handleSkip() {
        self.onBoardingCanceld()
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        
        swiftyOnboard?.goToPage(index: index + 1, animated: true)
        
        if index == 1 {
            self.onBoardingCanceld()
        }
    }
    
    private func onBoardingCanceld(){
        self.dismiss(animated: true) {
            UserDefaultsService.shared.saveData(true, keyValue: .isOnBoardShowed)
        }
    }
}

extension StoryboardExampleViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 2
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = CustomPage.instanceFromNib() as? CustomPage
        view?.image.image = UIImage(named: infoImages[index])
            view?.titleLabel.text = infoTitle[index]
            view?.subTitleLabel.text = infoDescr[index]

        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = CustomOverlay.instanceFromNib() as? CustomOverlay
        overlay?.skip.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay?.buttonContinue.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        overlay?.buttonContinue.layer.borderColor = UIColor.black.cgColor
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let overlay = overlay as! CustomOverlay
        let currentPage = round(position)
        overlay.contentControl.currentPage = Int(currentPage)
        overlay.buttonContinue.tag = Int(position)
        if currentPage == 0.0 {
            overlay.buttonContinue.setTitle("Continue", for: .normal)
            overlay.skip.setTitle("Skip", for: .normal)
            overlay.skip.isHidden = false
        } else {
            overlay.buttonContinue.setTitle("Get Started!", for: .normal)
            overlay.skip.isHidden = true
        }
    }
}
