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
    weak var delegate: PlacePreviewDelegate?
    
    var isTourCreated = false {
        didSet{
            collectionView.reloadData()
        }
    }
    
    var places = Array<Place>(){
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    fileprivate var currentPage: Int = 0 {
        didSet {
            self.delegate?.didSelect(with: places[currentPage])
        }
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
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
        collectionView?.register(PlacePreview.self, forCellWithReuseIdentifier: PlacePreview.reuseIdentifier)
    }
    
    func scrollTo(itemIndex index: Int){
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
        cell.delegate = delegate
        cell.isTourCreated = isTourCreated
        cell.image = place.loadImage
        
        return cell
    }
}

extension PlacesCollectionView: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
}
