//
//  RestaurantDescription.swift
//  Travel-App
//
//  Created by Антон Иванов on 6/27/20.
//  Copyright © 2020 companyName. All rights reserved.
//

//let data = "[{\"form_id\":3465,\"canonical_name\":\"df_SAWERQ\",\"form_name\":\"Activity 4 with Images\",\"form_desc\":null}]".data(using: .utf8)!

import Foundation
import UIKit

struct RestaurantDescription: Codable, DescriptionProtocol {
    let header: String
    let description: [DescrElement]

    private enum CodingKeys: String, CodingKey {
        case header
        case description
    }
    
    func getAttributedString() -> NSAttributedString {
        let attrStr = NSMutableAttributedString(string: "")
        for val in self.description {
            let titleText = NSMutableAttributedString(
                string: "\n\n" + val.title,
                attributes: [
                    .font: UIFont(name: "AvenirNextLTPro-Demi", size: 14)!,
                    .foregroundColor: UIColor(named: "silver")!])
            
            attrStr.append(titleText)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 3
            
            if val.title == "Hours" {
                attrStr.append(self.getHoursAttr(with: val.data))
            } else {
                
                for paragraph in val.data {
                    let descriptionText = NSMutableAttributedString(
                        string: "\n\n" + paragraph,
                        attributes: [
                            .font: UIFont(name: "AvenirNextLTPro-Regular", size: 14)!,
                            .foregroundColor: UIColor(named: "onyx")!,
                            .paragraphStyle:paragraphStyle ])
                    
                    attrStr.append(descriptionText)
                }
            }
        }
        
        return attrStr
    }
    
    private func getHoursAttr(with data: [String]) -> NSAttributedString {
        let attrStr = NSMutableAttributedString(string: "\n")
        var i = 0
        for paragraph in data {
            
            var str = "\n" + paragraph
            if i == 2 {
               str = "\n\n" + paragraph
                i = 0
            }
            i += 1
            let descriptionText = NSMutableAttributedString(
                string: str,
                attributes: [
                    .font: UIFont(name: "AvenirNextLTPro-Regular", size: 14)!,
                    .foregroundColor: UIColor(named: "onyx")!])
            
            attrStr.append(descriptionText)
        }
        return attrStr
    }
}

struct DescrElement: Codable {

    let title: String
    let data: [String]

    private enum CodingKeys: String, CodingKey {
        case title
        case data
    }
}
