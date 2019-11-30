//
//  CategoryFilter.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/30/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class CategoryFilter: UIView {
    
    // MARK: - Property
    var delegate: CategoryFilterDelegate?
    
    var categories = [String](){
        didSet{
            self.categoryView.reloadData()
        }
    }
    
    // MARK: - Views
    
    private lazy var categoryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CategoryFilterCell.self, forCellWithReuseIdentifier: "itemCell")
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.contentInset = UIEdgeInsets(top: 0,
                                               left: 10,
                                               bottom: 0,
                                               right: 0)
        collection.showsHorizontalScrollIndicator = false
        collection.allowsMultipleSelection = false

        return collection
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func selectItem(at index: Int){
        self.categoryView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    // MARK: - Setup UI
    
    private func setupUI(){
        self.addSubview(self.categoryView)
        
        NSLayoutConstraint.activate([
            self.categoryView.topAnchor.constraint(equalTo: self.topAnchor),
            self.categoryView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.categoryView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.categoryView.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
}

extension CategoryFilter: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! CategoryFilterCell
        cell.title = self.categories[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.categories.count
    }
}

extension CategoryFilter: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CategoryFilterCell
        self.delegate?.categoryFilter(didSelectedItemAt: indexPath.item)
        cell?.showIndicator()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CategoryFilterCell
        cell?.removeIndicator()

    }
}


