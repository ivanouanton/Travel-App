//
//  PreferenceBoardViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/23/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class PreferenceBoardViewController: UIViewController {

    @IBOutlet weak var interestsCollection: UICollectionView!
    var names = ["Anders", "Kristian", "Sofia", "John", "Jenny", "Lina"]
    var colors = [UIColor(named: "heavy")!,
                  UIColor(named: "onyx")!,
                  UIColor(named: "pantone")!,
                  UIColor(named: "silver")!,
                  UIColor(named: "smokyTopaz")!,
                  UIColor(named: "heavy")!]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
    }
    
    
    func registerNib() {
        let nib = UINib(nibName: InterestsCollectionViewCell.nibName, bundle: nil)
        interestsCollection?.register(nib, forCellWithReuseIdentifier: InterestsCollectionViewCell.reuseIdentifier)
    }
}

extension PreferenceBoardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = self.interestsCollection.dequeueReusableCell(withReuseIdentifier: InterestsCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! InterestsCollectionViewCell
        let name = names[indexPath.row]
        cell.configureCell(name: name, image: UIImage(named: "create-tour")!, color: colors[indexPath.row])
        return cell

    }
}

extension PreferenceBoardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? InterestsCollectionViewCell{
            
        }

    }
}
