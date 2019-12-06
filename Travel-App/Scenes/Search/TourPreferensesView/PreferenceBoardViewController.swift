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
    @IBOutlet weak var durationCollection: UICollectionView!
    var names = ["Anders", "Kristian", "Sofia", "John", "Jenny", "Lina"]
    var colors = [UIColor(named: "heavy")!,
                  UIColor(named: "onyx")!,
                  UIColor(named: "pantone")!,
                  UIColor(named: "silver")!,
                  UIColor(named: "smokyTopaz")!,
                  UIColor(named: "heavy")!]
    var durations = ["A Few Hours", "Half Day", "Full Day"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
    }
    
    
    func registerNib() {
        let nib = UINib(nibName: InterestsCollectionViewCell.nibName, bundle: nil)
        interestsCollection?.register(nib, forCellWithReuseIdentifier: InterestsCollectionViewCell.reuseIdentifier)
        
        let nibDuration = UINib(nibName: SettingOptionCollectionViewCell.nibName, bundle: nil)
        durationCollection?.register(nibDuration, forCellWithReuseIdentifier: SettingOptionCollectionViewCell.reuseIdentifier)
    }
}

extension PreferenceBoardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.interestsCollection:
            return names.count
        case self.durationCollection:
            return durations.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        switch collectionView {
        case self.interestsCollection:
            let cell = self.interestsCollection.dequeueReusableCell(withReuseIdentifier: InterestsCollectionViewCell.reuseIdentifier,
                                                          for: indexPath) as! InterestsCollectionViewCell
            let name = names[indexPath.row]
            cell.configureCell(name: name, image: UIImage(named: "create-tour")!, color: colors[indexPath.row])
            return cell
        case self.durationCollection:
            let cell = self.durationCollection.dequeueReusableCell(withReuseIdentifier: SettingOptionCollectionViewCell.reuseIdentifier,
                                                          for: indexPath) as! SettingOptionCollectionViewCell
            let name = durations[indexPath.row]
            cell.configureCell(text: name, actImage: nil, defImage: nil)
            return cell
        default:
            return UICollectionViewCell()
        }
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
