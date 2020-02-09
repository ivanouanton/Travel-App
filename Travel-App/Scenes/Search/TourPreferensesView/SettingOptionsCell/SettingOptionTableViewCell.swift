//
//  SettingOptionTableViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class SettingOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: PreferenceOptionDelegate?
    var cellIndex: Int?

    var titles = [String]()
    var images = [UIImage]()
    
    private var selectedItems = [Int]()
    
    class var reuseIdentifier: String {
        return "settingTableCell"
    }
    class var nibName: String {
        return "SettingOptionTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.registerNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    private func registerNib() {
        let nib = UINib(nibName: SettingOptionCollectionViewCell.nibName, bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: SettingOptionCollectionViewCell.reuseIdentifier)
        collectionView.allowsMultipleSelection = true
    }
}

extension SettingOptionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.titles.count != 0{
            return self.titles.count
        }else if self.images.count != 0{
            return self.images.count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: SettingOptionCollectionViewCell.reuseIdentifier,
                                                           for: indexPath) as! SettingOptionCollectionViewCell
        if self.titles.count != 0{
            cell.configureCell(text: titles[indexPath.row], actImage: nil, defImage: nil)
        }else if self.images.count != 0{
            cell.configureCell(text: nil, actImage: images[indexPath.row], defImage: nil)
        }
        return cell
    }
}

extension SettingOptionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItems.append(indexPath.row)
        delegate?.didSelectItemsAt(selectedItems, tableCell: cellIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedItems.removeAll { $0 == indexPath.row }
        delegate?.didSelectItemsAt(selectedItems, tableCell: cellIndex)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = self.collectionView.frame.width
            let cellWidth = (width - 52)/3
            return CGSize(width: cellWidth, height: 82)
    }
}
