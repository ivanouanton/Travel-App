//
//  CategoryFilterViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 2/8/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class CategoryFilterViewCell: UITableViewCell {

    @IBOutlet weak var categoryFilter: CategoriesFilterView!
    
    weak var delegate: PreferenceOptionDelegate?
    private var categories = [PlaceCategory]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryFilter.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CategoryFilterViewCell: CategoryFilterViewDelegate {
    func didDeselect(_ category: PlaceCategory) {
        categories.removeAll { $0 == category }
        delegate?.didSelectCategories(categories)
    }
    
    func didSelect(_ category: PlaceCategory) {
        categories.append(category)
        delegate?.didSelectCategories(categories)
    }
}
