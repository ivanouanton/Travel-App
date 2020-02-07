//
//  HomePresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter: HomePresenterProtocol{
    weak var view: HomeViewProtocol!
    
    required init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func getAttributedDescription() -> NSMutableAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacingBefore = 10
        
        let attrStr = NSMutableAttributedString(string: "")
        let titleText = NSMutableAttributedString(
            string: "Traveling To Italy\n",
            attributes: [
                .font: UIFont(name: "AvenirNextLTPro-Demi", size: 16)!,
                .foregroundColor: UIColor(named: "heavy")!])
        
        attrStr.append(titleText)
        
        let subTitleText = NSMutableAttributedString(
            string: "Useful Phrases in Italian\n",
            attributes: [
                .font: UIFont(name: "AvenirNextLTPro-Demi", size: 14)!,
                .foregroundColor: UIColor(named: "silver")!,
                .paragraphStyle:paragraphStyle ])
        
        attrStr.append(subTitleText)

        paragraphStyle.lineSpacing = 6
        
        let descriptionText = NSMutableAttributedString(
            string: "Coventry is a city with a thousand years of history that has plenty to offer the visiting tourist. Located in the heart of Warwickshire, which is well-known as Shakespeare’s county, there are easy transport inksto historic Warwick, Rugby and Stratford-upon-Avon. Additionally, there are many things to see and do in and around Coventry itself.\n",
            attributes: [
                .font: UIFont(name: "AvenirNextLTPro-Regular", size: 14)!,
                .foregroundColor: UIColor(named: "onyx")!,
                .paragraphStyle:paragraphStyle ])
        
        attrStr.append(descriptionText)

        let paragraphStyle1 = NSMutableParagraphStyle()
        paragraphStyle1.paragraphSpacingBefore = 20
        paragraphStyle1.paragraphSpacing = 15
        
        attrStr.append(
            NSMutableAttributedString(
                string: "Where to buy train tickets?\n",
                attributes: [
                    .font: UIFont(name: "AvenirNextLTPro-Demi", size: 16)!,
                    .foregroundColor: UIColor(named: "heavy")!,
                    .paragraphStyle:paragraphStyle1]))
        
        attrStr.append(AttributedStringHelper.bulletedList(
            strings: [
            "Si - Yes",
            "No. No.",
            "Per favore. Please.",
            "Grazie. Thank you.",
            "Prego. You're welcome.",
            "Mi scusi. Excuse me.",
            "Buon giorno. Good morning."],
            textColor: UIColor(named: "onyx")!,
            font: UIFont(name: "AvenirNextLTPro-Regular", size: 14)!,
            bulletColor: UIColor(named: "heavy")!,
            bulletSize: 10))
        
        return attrStr
        }
}
