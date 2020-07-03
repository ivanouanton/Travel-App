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
    
    var startHTML = """
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
    <html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Content-Style-Type" content="text/css">
    <title></title>
    <style type="text/css">
    </style>
    </head>
    <body>
    <p class="p5"><br></p>
    <p class="p5"><span class="s3">Getting Around</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Explore the city on foot</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">Walking is by far the best and most convenient way to see Rome. If you’d rather use public transport, you can take either:</span></p>
    <p class="p1"><br></p>
    <ol padding-left: 0px;>
    <li><p class="p3"><span class="s2">Underground Metro (c. €1.50 per journey) – operates between 5.30am and 11.30pm (to 1.30am on Fridays and Saturdays); or</span></p></li>
    <li><p class="p3"><span class="s2">Atac Buses (c. €1.50 per journey) – most of which pass through Stazione Termini, and operate from 5.30am until midnight (limited service throughout the night). Times are difficult to predict, however you can use the Roma Bus app for useful information.</span></p></li>
    </ol>
    <p class="p4"><br></p>
    <p class="p5"><span class="s3">Tickets & Entry</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Book Colosseum and Forum tickets online</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">Entry to the Colosseum, Palatine and Roman Forum require tickets and, due to their popularity, the queues can be enormous. To avoid wasting time, book online via the button below. If you haven’t booked your ticket in advance, there are some ‘hidden’ ticket offices with significantly shorter lines than the ones you can find in front of the Colosseum’s main entrance. These are located in Largo della Salara Vecchia 5/6 (close to via dei Fori Imperiali), via dei Verbiti (close to the Colosseum) and via San Gregorio.</span></p>
    </body>
    </html>
    """
    
    var middleHTML = """
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
    <html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Content-Style-Type" content="text/css">
    <title></title>
    <style type="text/css">
    </style>
    </head>
    <body>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Book Vatican tickets online</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">Queues for the Vatican museums and Sistine Chapel can also be extremely long. However, if you book online you can skip the queue.</span></p>
    </body>
    </html>
    """
    
    var endHTML = """
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
    <html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Content-Style-Type" content="text/css">
    <title></title>
    <style type="text/css">
    </style>
    </head>
    <body>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Museums closed on Mondays</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">A number of museums are closed on Mondays (Vatican Museums close on Sunday), so try, if possible to visit them from Tuesday to Friday.</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">Most of Rome’s museums and galleries are free on the first Sunday of each month. Get there early on those days, as long queues form very quickly.</span></p>
    <p class="p5"><br></p>
    <p class="p5"><span class="s3">Eating & Drinking</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Dinner starts late</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">Italians usually meet for an <i class="italic">aperitivo<i> at around 7pm, with dinner beginning at around 8 – 9pm. However, don’t be surprised to see the locals starting their meals even later at the weekends.</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Try the local food</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">Make sure you sample Rome’s most famous local dish, pasta <i class="italic">cacio e pepe</i>, meaning ‘pasta with cheese and pepper’. It’s a simple meal originally devised by early Roman shepherds and you’ll find different variations of it in every trattoria, particularly the Testaccio district. Other local delicacies include fried artichokes (<i class="italic">carciofi alla Romana</i>), deep fried rice croquettes (<i class="italic">supplí</i>), fried cod fish (<i class="italic">filetti di baccalá</i>) and, of course, pizza sold by the slice (<i class="italic">pizza al taglio</i>).</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Order the house wine</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">If in doubt, go for the house wine. It’s usually affordable and very good quality.</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Experience Roman nightlife</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">Head over to Trastevere in the west of the city, a picturesque district famed for its restaurants and bars. Other popular areas include the Campo de’ Fiori district and San Lorenzo (university area).</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Enjoy the free water</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">A number of Rome’s streets have small drinking fountains called <i class="italic">nasoni</i>, or ‘little noses’, due to their curved shape.</span></p>
    <p class="p5"><br></p>
    <p class="p5"><span class="s3">Money & Tipping</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Carry some cash</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">Although many restaurants now accept card, it’s best to be safe by carrying some cash, particularly as some places don’t like splitting the bill.</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Tipping is optional</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">A service charge (<i class="italic">or coperto</i>) is generally included in the bill.</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Order coffee at the bar</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">This way you’ll avoid paying an expensive service charge. You’ll also be like the locals, who won’t linger around drinking theirs.</span></p>
    <p class="p5"><br></p>
    <p class="p5"><span class="s3">Attire</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Dress modestly in churches</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">If you’re planning on visiting any of the city’s 900 or so churches, make sure your shoulders are covered and bottoms extend to the knees or beyond.</span></p>
    <p class="p4"><br></p>
    <p class="p2"><span class="s1">Wear comfortable shoes</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2">Rome’s winding streets are as uneven as they are historic.</span></p>
    <p class="p5"><br></p>
    <p class="p5"><span class="s3">Useful Words & Phrases</span></p>
    <p class="p4"><br></p>
    <p class="p3"><span class="s2"><i class="italic">Ciao</i> – Hi and Bye</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2"><i class="italic">Per favour </i>– Please</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2"><i class="italic">Grazie </i>– Thank you</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2"><i class="italic">Mi scusi, quanto costa? </i>– Excuse me, how much does it cost?</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2"><i class="italic">Posso pagare con la carta? </i>– Can I pay with a card?</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2"><i class="italic">Posso prenotare un tavolo per due? </i>– Can I book a table for two?</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2"><i class="italic">Possiamo ordinare? </i>– Can we order?</span></p>
    <p class="p1"><br></p>
    <p class="p3"><span class="s2"><i class="italic">Possiamo avere il conto, per favore? </i>– Can we please have the bill?</span></p>
    </body>
    </html>
    """
    
    let style = """
    <style type="text/css">
    p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 7.0px 'Avenir Next LT Pro'; color: #c2c0c1; min-height: 16.8px}
    p.p2 {margin: 0.0px 0.0px 0.0px 0.0px; font: 10.0px 'Avenir Next LT Pro'; color: #c2c0c1}
    p.p3 {margin: 0.0px 0.0px 0.0px 0.0px; font: 10.0px 'Avenir Next LT Pro'; color: #363739}
    p.p4 {margin: 0.0px 0.0px 0.0px 0.0px; font: 9.0px 'Avenir Next LT Pro'; color: #363739; min-height: 16.8px}
    p.p5 {margin: 0.0px 0.0px 0.0px 0.0px; font: 24.0px 'Avenir Next LT Pro'; color: #0F2B44}

    span.s1 {font-family: 'AvenirNextLTPro-Demi'; font-weight: bold; font-style: normal; font-size: 14.00px}
    span.s2 {font-family: 'AvenirNextLTPro-Regular'; font-weight: normal; line-height: 130%; font-style: normal; font-size: 14.00px}
    span.s3 {font-family: 'AvenirNextLTPro-Demi'; font-weight: bold; font-style: normal; font-size: 16.00px}
    span.italic {font-family: 'AvenirNextLTPro-Italic'; font-weight: normal; font-style: normal; font-size: 14.00px}
    </style>
    """
    
    required init(view: HomeViewProtocol) {
        self.view = view
    }
    
    private func getDescription(with html: String) -> NSAttributedString{
                
        let prettyHtml = html.replacingOccurrences(of: "\\", with: "")

        let htmlWithTitle = prettyHtml.replacingOccurrences(of: "<style type=\"text/css\">\n</style>", with: style)
        let data = Data(htmlWithTitle.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
        }
        
        return NSAttributedString(string: "Description will be added soon")
    }
    
    func getAttributedString() -> NSAttributedString {
        
        return getDescription(with: startHTML)
    }
    
    func getAttributedMiddleDescription() -> NSAttributedString {
        
        return getDescription(with: middleHTML)
    }
    
    func getAttributedEndDescription() -> NSAttributedString {
        return getDescription(with: endHTML)
    }

    func getAttributedDescription() -> NSAttributedString {
        
        return getAttributedString()
    }
}
