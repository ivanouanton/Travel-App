//
//  RecentPlacesTableViewCell.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/13/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class RecentPlacesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recentPlacesCollection: UICollectionView!
    
    var places = Array<Place>() {
        didSet {
            self.recentPlacesCollection.reloadData()
        }
    }
    
    class var reuseIdentifier: String {
        return "RecentPlacesTableViewCell"
    }
    class var nibName: String {
        return "RecentPlacesTableViewCell"
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
        let nib = UINib(nibName: RecentPlaceCollectionViewCell.nibName, bundle: nil)
        self.recentPlacesCollection?.register(nib, forCellWithReuseIdentifier: RecentPlaceCollectionViewCell.reuseIdentifier)
    }
    
}

extension RecentPlacesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return places.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = self.recentPlacesCollection.dequeueReusableCell(withReuseIdentifier: RecentPlaceCollectionViewCell.reuseIdentifier,
                                                                 for: indexPath) as! RecentPlaceCollectionViewCell
        let place = places[indexPath.item]
        cell.place = place
        if let ref = place.image {
            TAImageClient.getImage(with: ref) { (image, error) in
                if let image = image {
                    cell.placeImage.image = image
                }
            }
        }
        
        return cell
    }
}
