//
//  PreferenceBoardViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/23/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class PreferenceBoardViewController: UIViewController {
    
    var settingsData = [
        "Interests": [
            CategoryPreference(title: "Anders", icon: UIImage(named: "landmark")!),
            CategoryPreference(title: "Kristian", icon: UIImage(named: "trees")!),
            CategoryPreference(title: "Sofia", icon: UIImage(named: "landmark")!),
            CategoryPreference(title: "John", icon: UIImage(named: "trees")!),
            CategoryPreference(title: "Jenny", icon: UIImage(named: "landmark")!),
            CategoryPreference(title: "Lina", icon: UIImage(named: "trees")!)
        ],
        "Duration": ["A Few Hours", "Half Day",  "Full Day"],
        "Price": ["free", "$", "$$", "$$$"],
        "Transport": ["train", "car", "walk"]
    ]
    
    
    var answers = [Int:Int]()
    
    var sectionTitles = ["Interests", "Duration", "Price", "Transport"]
    
    private lazy var settingTable: UITableView = {
        let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        let interestCell = UINib(nibName: "InterestsTableCell", bundle: nil)
        table.register(interestCell, forCellReuseIdentifier: "InterestsTableCell")
        let settingsCell = UINib(nibName: SettingOptionTableViewCell.nibName, bundle: nil)
        table.register(settingsCell, forCellReuseIdentifier: SettingOptionTableViewCell.reuseIdentifier)
        table.backgroundColor = UIColor(named: "white")
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        return table
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Select Preferences"
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor(named: "pantone")!,
         NSAttributedString.Key.font: UIFont(name: "AvenirNextLTPro-Demi", size: 16)!]
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let view = UIView()
        view.backgroundColor = .white
        
            let title = UILabel()
            view.addSubview(title)
            title.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                title.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
                title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                title.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
        title.textColor = UIColor(named: "pantone")
        title.textAlignment = .left
        title.font = UIFont(name: "AvenirNextLTPro-Demi", size: 16)
        title.text = self.sectionTitles[section]
      return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section != 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionTableViewCell.reuseIdentifier, for: indexPath) as! SettingOptionTableViewCell
            let key: String = self.sectionTitles[indexPath.section]
            cell.titles = settingsData[key] as! [String]
            cell.delegate = self
            cell.cellIndex = indexPath.section
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "InterestsTableCell", for: indexPath) as! InterestsTableCell
            cell.categories = settingsData["Interests"] as! [CategoryPreference]
            cell.delegate = self
            cell.cellIndex = indexPath.section
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        
        if section == self.sectionTitles.count - 1{
            let button = AppButton()
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
                button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 44),
                button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35)
            ])
            button.layer.cornerRadius = 5
            button.setTitle("Done", for: .normal)
            button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
            button.setTitleColor(UIColor(named: "pantone"), for: .normal)
            button.setTitleColor(UIColor(named: "white"), for: .highlighted)
            button.setTitleShadowColor(.red, for: .normal)
            button.setTitleShadowColor(.blue, for: .highlighted)
            button.addTarget(self, action: #selector(dosmth), for: .touchUpInside)
            button.mainColor = UIColor(named: "pantone")!.withAlphaComponent(0.2)
            button.highlitedColor = UIColor(named: "pantone")!
        }

      return view
    }
    
    @objc func dosmth(){
        print(self.answers)
    }
}

extension PreferenceBoardViewController: PreferenceOptionDelegate{
    func didSelectItemAt(_ index: Int, tableCell: Int?) {
        guard let tableCellIndex = tableCell else { return }
        self.answers[tableCellIndex] = index
    }
}

