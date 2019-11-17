//
//  SettingsPresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

class SettingsPresenter: SettingsPresenterProtocol{
    weak var view: SettingsViewProtocol!
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
}
