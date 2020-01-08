//
//  SettingsPresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

class SettingsPresenter: SettingsPresenterProtocol{
    func getSettingsProperty() {
        let properties = [
            ("Preferences", [
                ("Distance Units", "Metric, km"),
                ("Currency", "€" ?? "")
            ]),
            ("Help & Information",
             [
                ("FAQs", nil),
                ("About Us", nil),
                ("Terms and Conditions", nil),
                ("Privacy Statement", nil)
            ])
        ]
        self.view.updateTable(with: properties)
    }
    
    weak var view: SettingsViewProtocol!
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
}
