//
//  PreferenceBoardViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/23/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class PreferenceBoardViewController: UIViewController {

    var peekImplementation: MSPeekCollectionViewDelegateImplementation!

    @IBOutlet weak var interestsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peekImplementation = MSPeekCollectionViewDelegateImplementation()
        peekImplementation.delegate = self
        interestsCollection.configureForPeekingDelegate()
        interestsCollection.delegate = peekImplementation
        interestsCollection.dataSource = self
        
          initSliderValues()
    }
        
    func initSliderValues() {
        peekImplementation = MSPeekCollectionViewDelegateImplementation(cellSpacing: 24,
                                                                        cellPeekWidth: 140,
                                                                        scrollThreshold: 50,
                                                                        maximumItemsToScroll: 1,
                                                                        numberOfItemsToShow: 2)
        interestsCollection.delegate = peekImplementation
        peekImplementation.delegate = self
        interestsCollection.reloadData()
    }
}

extension PreferenceBoardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath) as UICollectionViewCell
        let value =  (180 + CGFloat(indexPath.row)*20) / 255
        cell.contentView.backgroundColor = UIColor(red: value, green: value, blue: value, alpha: 1)
        return cell
    }
}

extension PreferenceBoardViewController: MSPeekImplementationDelegate {
    func peekImplementation(_ peekImplementation: MSPeekCollectionViewDelegateImplementation, didChangeActiveIndexTo activeIndex: Int) {
        print("Changed active index to \(activeIndex)")
    }
    
    func peekImplementation(_ peekImplementation: MSPeekCollectionViewDelegateImplementation, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at \(indexPath)")
    }
}
