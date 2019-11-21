//
//  SettingsPresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

class SettingsPresenter: SettingsPresenterProtocol{
    func getSettingsProperty() {
        var properties = [
            ("Preferences", ["Notifications", "Distance Units", "Currency"]),
            ("Help & Information", ["FAQs", "About Us", "Terms and Conditions", "Privacy Statement"])
        ]
        self.view.updateTable(with: properties)
    }
    
    weak var view: SettingsViewProtocol!
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
}
