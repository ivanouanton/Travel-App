//
//  AgreementType.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/16/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit
import Foundation

enum AgreementType{
    case termsAndConditions
    case privacyStatement
    
    func message() -> NSAttributedString{
        switch self{
        case .termsAndConditions:
            let quote = "Haters gonna hate"
            let font = UIFont.systemFont(ofSize: 72)
            let attributes = [NSAttributedString.Key.font: font]
            let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
            return attributedQuote
        case .privacyStatement:
        
            let quote = "Haters gonna hate"
            let font = UIFont.systemFont(ofSize: 72)
            let attributes = [NSAttributedString.Key.font: font]
            let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
            return attributedQuote

        }
    }
    
}


extension AgreementType{
    func getTitle() -> String{
        switch self {
        case .termsAndConditions:
            return "Terms and Conditions"
        case .privacyStatement:
            return "Privacy Statement"
        }
    }
    
    func getAttributedString() -> NSAttributedString{
        switch self {
        case .termsAndConditions:
            return createAttributedString(data: AgreementType.termsAndConditionsText)
        case .privacyStatement:
            return createAttributedString(data: AgreementType.privacyStatementText)
        }
    }
    
    private func createAttributedString(data: [[String : String]]) -> NSAttributedString{
        let attrStr = NSMutableAttributedString(string: "")
        for val in data {
            let titleText = NSMutableAttributedString(
                string: val["title"]! + "\n\n",
                attributes: [
                    .font: UIFont(name: "AvenirNextLTPro-Demi", size: 14)!,
                    .foregroundColor: UIColor(named: "heavy")!])
            
            attrStr.append(titleText)

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 3
            
            let descriptionText = NSMutableAttributedString(
                string: val["description"]! + "\n\n\n",
                attributes: [
                    .font: UIFont(name: "AvenirNextLTPro-Regular", size: 14)!,
                    .foregroundColor: UIColor(named: "onyx")!,
                    .paragraphStyle:paragraphStyle ])
            
            attrStr.append(descriptionText)
        }
        
        return attrStr
    }
    
    static let termsAndConditionsText: [[String : String]] = [
        ["title" : "1. Who may use service?",
         "description" : "Stu Unger is one of the biggest superstars to have immerged from the professional poker world. Besides being a true poker genius and a three time World Series of Poker champion, Stu Unger had a fascinating life story. It was not surprising that after his death Stu was the subject of a biography and a biopic."],
        ["title" : "2. Privacy",
        "description" : "The collapse of the online-advertising market in 2001 made marketing on the Internet seem even less compelling. Website usability, press releases, online media buys, podcasts, mobile marketing and more – there’s an entire world of internet advertising opportunities to explore. We specialize in internet marketing strategy, online advertising, web marketing and conversion."],
        ["title" : "1. Authorized Users",
         "description" : "Stu Unger is one of the biggest superstars to have immerged from the professional poker world. Besides being a true poker genius and a three time World Series of Poker champion, Stu Unger had a fascinating life story. It was not surprising that after his death Stu was the subject of a biography and a biopic."],
        ["title" : "2. Condition of Use",
        "description" : "The collapse of the online-advertising market in 2001 made marketing on the Internet seem even less compelling. Website usability, press releases, online media buys, podcasts, mobile marketing and more – there’s an entire world of internet advertising opportunities to explore. We specialize in internet marketing strategy, online advertising, web marketing and conversion."],
        
    ]
    
    static let privacyStatementText: [[String : String]] = [
        ["title" : "1. Authorized Users",
         "description" : "Stu Unger is one of the biggest superstars to have immerged from the professional poker world. Besides being a true poker genius and a three time World Series of Poker champion, Stu Unger had a fascinating life story. It was not surprising that after his death Stu was the subject of a biography and a biopic."],
        ["title" : "2. Condition of Use",
        "description" : "The collapse of the online-advertising market in 2001 made marketing on the Internet seem even less compelling. Website usability, press releases, online media buys, podcasts, mobile marketing and more – there’s an entire world of internet advertising opportunities to explore. We specialize in internet marketing strategy, online advertising, web marketing and conversion."]
    ]
}
