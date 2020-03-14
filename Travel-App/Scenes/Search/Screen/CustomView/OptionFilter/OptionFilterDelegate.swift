//
//  OptionFilterDelegate.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/15/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

protocol OptionFilterDelegate: class {
    func didPressedFilterButton(with activeFilterHeight: CGFloat)
    func didSelected(with option: OptionFilterSelection)
    func didDeselect(with option: OptionFilterSelection)
}
