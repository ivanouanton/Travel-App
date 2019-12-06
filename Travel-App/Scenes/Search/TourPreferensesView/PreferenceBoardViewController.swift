//
//  PreferenceBoardViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/23/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class PreferenceBoardViewController: UIViewController {
    
    

//    @IBOutlet weak var interestsCollection: UICollectionView!
//    @IBOutlet weak var durationCollection: UICollectionView!

    
    var settingsData = [
        "Interests": [
            CategoryPreference(title: "Anders", icon: UIImage(named: "avatar-def")!),
            CategoryPreference(title: "Kristian", icon: UIImage(named: "avatar")!),
            CategoryPreference(title: "Sofia", icon: UIImage(named: "avatar-def")!),
            CategoryPreference(title: "John", icon: UIImage(named: "avatar")!),
            CategoryPreference(title: "Jenny", icon: UIImage(named: "avatar-def")!),
            CategoryPreference(title: "Lina", icon: UIImage(named: "avatar")!)
        ],
        "Duration": ["A Few Hours", "Half Day",  "Full Day"],
        "Price": ["free", "$", "$$"],
        "Transport": ["train", "car", "walk"]
    ]
    
    var sectionTitles = ["Interests", "Duration", "Price", "Transport"]
    
    var colors = [UIColor(named: "heavy")!,
                  UIColor(named: "onyx")!,
                  UIColor(named: "pantone")!,
                  UIColor(named: "silver")!,
                  UIColor(named: "smokyTopaz")!,
                  UIColor(named: "heavy")!]
    
    private lazy var settingTable: UITableView = {
        let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(InterestsTableCell.self, forCellReuseIdentifier: "SettingTableViewCell")
        table.dataSource = self
        table.delegate = self
        return table
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.settingTable)
        self.setupConstrainnts()
    }
    
    private func setupConstrainnts(){
        NSLayoutConstraint.activate([
            self.settingTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.settingTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.settingTable.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.settingTable.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension PreferenceBoardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.settingTable.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! InterestsTableCell
        cell.backgroundColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        
        if section == self.sectionTitles.count - 1{
            view.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40)
        }
      let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
      footerView.backgroundColor = UIColor.blue

      return view
    }

//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
//        footerView.backgroundColor = .blue
//        return footerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 50
//    }
}


//    func registerNib() {
//        let nib = UINib(nibName: InterestsCollectionViewCell.nibName, bundle: nil)
//        interestsCollection?.register(nib, forCellWithReuseIdentifier: InterestsCollectionViewCell.reuseIdentifier)
//
//        let nibDuration = UINib(nibName: SettingOptionCollectionViewCell.nibName, bundle: nil)
//        durationCollection?.register(nibDuration, forCellWithReuseIdentifier: SettingOptionCollectionViewCell.reuseIdentifier)
//    }


//extension PreferenceBoardViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        switch collectionView {
//        case self.interestsCollection:
//            return names.count
//        case self.durationCollection:
//            return durations.count
//        default:
//            return 0
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        switch collectionView {
//        case self.interestsCollection:
//            let cell = self.interestsCollection.dequeueReusableCell(withReuseIdentifier: InterestsCollectionViewCell.reuseIdentifier,
//                                                          for: indexPath) as! InterestsCollectionViewCell
//            let name = names[indexPath.row]
//            cell.configureCell(name: name, image: UIImage(named: "create-tour")!, color: colors[indexPath.row])
//            return cell
//        case self.durationCollection:
//            let cell = self.durationCollection.dequeueReusableCell(withReuseIdentifier: SettingOptionCollectionViewCell.reuseIdentifier,
//                                                          for: indexPath) as! SettingOptionCollectionViewCell
//            let name = durations[indexPath.row]
//            cell.configureCell(text: name, actImage: nil, defImage: nil)
//            return cell
//        default:
//            return UICollectionViewCell()
//        }
//    }
//}
//
//extension PreferenceBoardViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        if let cell = collectionView.cellForItem(at: indexPath) as? InterestsCollectionViewCell{
////
////        }
//
//    }
//
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        if collectionView == durationCollection{
////            let width = self.durationCollection.frame.height
////            let cellWidth = (width - 92)/3
////            return CGSize(width: cellWidth, height: self.durationCollection.frame.height)
////
////        }
////
////        return CGSize(width: 10, height: 10)
////    }
//}
