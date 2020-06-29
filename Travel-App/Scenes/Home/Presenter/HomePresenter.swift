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
    
    var jsonStr1 = """
    [
      {
        "header" : "Getting Around",
        "description" : [
          {
            "title" : "Explore the city on foot",
            "data" : [
              "Walking is by far the best and most convenient way to see Rome. If you’d rather use public transport, you can take either:",
              "1.   Underground Metro (c. €1.50 per journey) – operates between 5.30am and 11.30pm (to 1.30am on Fridays and Saturdays); or",
              "2.   Atac Buses (c. €1.50 per journey) – most of which pass through Stazione Termini, and operate from 5.30am until midnight (limited service throughout the night). Times are difficult to predict, however you can use the Roma Bus app for useful information."
            ]
          }
        ]
      },
      {
        "header" : "Tickets & Entry",
        "description" : [
          {
            "title" : "Book Colosseum and Forum tickets online",
            "data" : [
              "Entry to the Colosseum, Palatine and Roman Forum require tickets and, due to their popularity, the queues can be enormous. To avoid wasting time, book online via the button below. If you haven’t booked your ticket in advance, there are some ‘hidden’ ticket offices with significantly shorter lines than the ones you can find in front of the Colosseum’s main entrance. These are located in Largo della Salara Vecchia 5/6 (close to via dei Fori Imperiali), via dei Verbiti (close to the Colosseum) and via San Gregorio."
            ]
          }
        ]
      }
    ]
    """
    
    var jsonStr2 = """
    {
      "header" : "Tickets & Entry",
      "description" : [
        {
          "title" : "Book Vatican tickets online",
          "data" : [
            "Queues for the Vatican museums and Sistine Chapel can also be extremely long. However, if you book online you can skip the queue."
          ]
        }
      ]
    }
    """
    
    var jsonStr31 = """
    {
      "header" : "Tickets & Entry",
      "description" : [
        {
          "title" : "Museums closed on Mondays",
          "data" : [
            "A number of museums are closed on Mondays (Vatican Museums close on Sunday), so try, if possible to visit them from Tuesday to Friday."
          ]
        },
        {
          "title" : "Free entry on certain Sundays",
          "data" : [
            "Most of Rome’s museums and galleries are free on the first Sunday of each month. Get there early on those days, as long queues form very quickly."
          ]
        }
      ]
    }
    """
    
    var jsonStr32 = """
    [
      {
        "header" : "Eating & Drinking",
        "description" : [
          {
            "title" : "Dinner starts late",
            "data" : [
              "Italians usually meet for an aperitivo at around 7pm, with dinner beginning at around 8 – 9pm. However, don’t be surprised to see the locals starting their meals even later at the weekends."
            ]
          },
          {
            "title" : "Try the local food",
            "data" : [
              "Make sure you sample Rome’s most famous local dish, pasta cacio e pepe, meaning ‘pasta with cheese and pepper’. It’s a simple meal originally devised by early Roman shepherds and you’ll find different variations of it in every trattoria, particularly the Testaccio district. Other local delicacies include fried artichokes (carciofi alla Romana), deep fried rice croquettes (supplí), fried cod fish (filetti di baccalá) and, of course, pizza sold by the slice (pizza al taglio)."
            ]
          },
          {
            "title" : "Order the house wine",
            "data" : [
              "If in doubt, go for the house wine. It’s usually affordable and very good quality."
            ]
          },
          {
            "title" : "Experience Roman nightlife",
            "data" : [
              "Head over to Trastevere in the west of the city, a picturesque district famed for its restaurants and bars. Other popular areas include the Campo de’ Fiori district and San Lorenzo (university area)."
            ]
          },
          {
            "title" : "Enjoy the free water",
            "data" : [
              "A number of Rome’s streets have small drinking fountains called nasoni, or ‘little noses’, due to their curved shape."
            ]
          }
        ]
      },
      {
        "header" : "Money & Tipping",
        "description" : [
          {
            "title" : "Carry some cash",
            "data" : [
              "Although many restaurants now accept card, it’s best to be safe by carrying some cash, particularly as some places don’t like splitting the bill."
            ]
          },
          {
            "title" : "Tipping is optional",
            "data" : [
              "A service charge (or coperto) is generally included in the bill."
            ]
          },
          {
            "title" : "Order coffee at the bar",
            "data" : [
              "This way you’ll avoid paying an expensive service charge. You’ll also be like the locals, who won’t linger around drinking theirs."
            ]
          }
        ]
      },
      {
        "header" : "Attire",
        "description" : [
          {
            "title" : "Dress modestly in churches",
            "data" : [
              "If you’re planning on visiting any of the city’s 900 or so churches, make sure your shoulders are covered and bottoms extend to the knees or beyond."
            ]
          },
          {
            "title" : "Wear comfortable shoes",
            "data" : [
              "Rome’s winding streets are as uneven as they are historic."
            ]
          }
        ]
      }
    ]
    """
    
    var jsonStr33 = """
    {
      "header" : "Useful Words & Phrases",
      "description" : [
        {
          "title" : "",
          "data" : [
            "Ciao – Hi and Bye",
            "Per favour – Please",
            "Grazie – Thank you",
            "Mi scusi, quanto costa? – Excuse me, how much does it cost?",
            "Posso pagare con la carta? – Can I pay with a card?",
            "Posso prenotare un tavolo per due? – Can I book a table for two?",
            "Possiamo ordinare? – Can we order?",
            "Possiamo avere il conto, per favore? – Can we please have the bill?"
          ]
        }
      ]
    }
    """
    
    
    
    required init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func getAttributedString() -> NSAttributedString {
        
        let chapters = try? JSONDecoder().decode([RestaurantDescription].self, from: jsonStr1.data(using: .utf8)!)
        guard let chpts = chapters else {return NSAttributedString()}
        
        let attrStr = NSMutableAttributedString(string: "")
        for val in chpts {
            let titleText = NSMutableAttributedString(
                string: "\n\n" + val.header,
                attributes: [
                    .font: UIFont(name: "AvenirNextLTPro-Demi", size: 16)!,
                    .foregroundColor: UIColor(named: "heavy")!])
            
            attrStr.append(titleText)
            attrStr.append(self.getSubTitleAttrString(with: val))
        }
        
        return attrStr
    }
    
    private func getSubTitleAttrString(with data: RestaurantDescription) -> NSAttributedString {
        let attrStr = NSMutableAttributedString(string: "")
        for val in data.description {
            let titleText = NSMutableAttributedString(
                string: "\n\n" + val.title,
                attributes: [
                    .font: UIFont(name: "AvenirNextLTPro-Demi", size: 14)!,
                    .foregroundColor: UIColor(named: "silver")!])
            
            attrStr.append(titleText)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 3
            
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
        
        return attrStr
    }
    
    func getAttributedMiddleDescription() -> NSAttributedString {
        let chapter = try? JSONDecoder().decode(RestaurantDescription.self, from: jsonStr2.data(using: .utf8)!)
        guard let chpt = chapter else {return NSAttributedString()}
        
        let attrStr = NSMutableAttributedString(string: "")
        attrStr.append(self.getSubTitleAttrString(with: chpt))
        
        return attrStr
    }
    
    func getAttributedEndDescription() -> NSAttributedString {
        let chapter = try? JSONDecoder().decode(RestaurantDescription.self, from: jsonStr31.data(using: .utf8)!)
        guard let chpt = chapter else {return NSAttributedString()}
        
        let attrStr = NSMutableAttributedString(string: "")
        attrStr.append(self.getSubTitleAttrString(with: chpt))
        
        let chapters = try? JSONDecoder().decode([RestaurantDescription].self, from: jsonStr32.data(using: .utf8)!)
        guard let chpts = chapters else {return NSAttributedString()}
        
        for val in chpts {
            let titleText = NSMutableAttributedString(
                string: "\n\n" + val.header,
                attributes: [
                    .font: UIFont(name: "AvenirNextLTPro-Demi", size: 16)!,
                    .foregroundColor: UIColor(named: "heavy")!])
            
            attrStr.append(titleText)
            attrStr.append(self.getSubTitleAttrString(with: val))
        }
        
        attrStr.append(NSMutableAttributedString(string: "\n\n"))
        
        let bulleteList = try? JSONDecoder().decode(RestaurantDescription.self, from: jsonStr33.data(using: .utf8)!)
        guard let bullets = bulleteList else {return NSAttributedString()}
        
        let titleText = NSMutableAttributedString(
            string: bullets.header + "\n\n",
            attributes: [
                .font: UIFont(name: "AvenirNextLTPro-Demi", size: 16)!,
                .foregroundColor: UIColor(named: "heavy")!])
        
        attrStr.append(titleText)
        
        attrStr.append(AttributedStringHelper.bulletedList(
            strings: bullets.description.first!.data,
            textColor: UIColor(named: "onyx")!,
            font: UIFont(name: "AvenirNextLTPro-Regular", size: 14)!,
            bulletColor: UIColor(named: "heavy")!,
            bulletSize: 10))
        
        return attrStr
    }

    
    func getAttributedDescription() -> NSAttributedString {
        
        return getAttributedString()
    }
}
