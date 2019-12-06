//
//  InterestsTableCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/6/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class InterestsTableCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var categories = [CategoryPreference]()
    
    var colors = [UIColor(named: "blue")!,
                  UIColor(named: "yellow")!,
                  UIColor(named: "green")!,
                  UIColor(named: "orange")!,
                  UIColor(named: "red")!,
                  UIColor(named: "violet")!]
    
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
        let nib = UINib(nibName: InterestsCollectionViewCell.nibName, bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: InterestsCollectionViewCell.reuseIdentifier)
    }
}

extension InterestsTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: InterestsCollectionViewCell.reuseIdentifier,
                                                                 for: indexPath) as! InterestsCollectionViewCell
        let name = self.categories[indexPath.row]
        cell.configureCell(name: name.title, image: name.icon, color: colors[indexPath.row])
        return cell
    }
}

extension PreferenceBoardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? InterestsCollectionViewCell{
//
//        }

    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == durationCollection{
//            let width = self.durationCollection.frame.height
//            let cellWidth = (width - 92)/3
//            return CGSize(width: cellWidth, height: self.durationCollection.frame.height)
//
//        }
//
//        return CGSize(width: 10, height: 10)
//    }
}

