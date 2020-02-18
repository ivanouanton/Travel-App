//
//  PreferenceOptionDelegate.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

protocol PreferenceOptionDelegate: class{
    func didSelectItemsAt(_ items: [Int], tableCell: Int?)
    func didSelectCategories(_ categories: [PlaceCategory])
}
