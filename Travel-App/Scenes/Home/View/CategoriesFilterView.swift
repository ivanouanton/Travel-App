//
//  CategoriesFilterView.swift
//  Travel-App
//
//  Created by Anton Ivanov on 1/30/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class CategoriesFilterView: UIView {
    let kCONTENT_XIB_NAME = "CategoriesFilterView"

    @IBOutlet var contentView: UIView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        //        let nib = UINib(nibName: InterestsCollectionViewCell.nibName, bundle: nil)
        //        categoryCollection?.register(nib, forCellWithReuseIdentifier: InterestsCollectionViewCell.reuseIdentifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
}

//extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return PlaceCategory.categories.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: InterestsCollectionViewCell.reuseIdentifier,
//                                                                 for: indexPath) as! InterestsCollectionViewCell
//        let name = self.categories[indexPath.row]
//        cell.configureCell(name: name.title, image: name.icon, color: colors[indexPath.row])
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.delegate?.didSelectItemAt(indexPath.row, tableCell: self.cellIndex)
//    }
//}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
