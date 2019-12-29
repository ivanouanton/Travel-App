//
//  PlacesCollectionView.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/28/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class PlacesCollectionView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var places = Array<PlaceCardModel>(){
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
//        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.register(PlacePreview.self, forCellWithReuseIdentifier: PlacePreview.reuseIdentifier)
    }

}

extension PlacesCollectionView: UICollectionViewDataSource{

    // MARK: - Place Collection Delegate & DataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlacePreview.reuseIdentifier, for: indexPath) as! PlacePreview
        let place = self.places[indexPath.row]
        cell.place = place
        return cell
    }
}

extension PlacesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 40, height: frame.height)
    }
}
