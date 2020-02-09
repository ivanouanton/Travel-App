//
//  PreferenceBoardViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/23/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class PreferenceBoardViewController: UIViewController {
    
    var presenter: PreferenceBoardPresenterProtocol!
    
    var settingsData = [
        "Duration": ["A Few Hours", "Half Day",  "Full Day"],
        "Price": ["free", "€", "€€"],
        "Transport": [UIImage(named: "walk")!, UIImage(named: "bus")!, UIImage(named: "subway")!]
    ]
    
    var preferences = [Int:[Int]]()
    var selectedCategories = [PlaceCategory]()
    var selectedPrices = [Int]()
    var selectedDurations = [0]

    var sectionTitles = ["Interests", "Duration", "Price"]
    
    private lazy var settingTable: UITableView = {
        let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        let interestCell = UINib(nibName: "CategoryFilterViewCell", bundle: nil)
        table.register(interestCell, forCellReuseIdentifier: "CategoryFilterViewCell")
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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryFilterViewCell", for: indexPath) as! CategoryFilterViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionTableViewCell.reuseIdentifier, for: indexPath) as! SettingOptionTableViewCell
            let key: String = self.sectionTitles[indexPath.section]
            cell.titles = settingsData[key] as! [String]
            cell.delegate = self
            cell.cellIndex = indexPath.section
            cell.allowsMultipleSelection = false
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionTableViewCell.reuseIdentifier, for: indexPath) as! SettingOptionTableViewCell
            let key: String = self.sectionTitles[indexPath.section]
            cell.titles = settingsData[key] as! [String]
            cell.delegate = self
            cell.cellIndex = indexPath.section
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionTableViewCell.reuseIdentifier, for: indexPath) as! SettingOptionTableViewCell
            let key: String = self.sectionTitles[indexPath.section]
            cell.images = settingsData[key] as! [UIImage]
            cell.delegate = self
            cell.cellIndex = indexPath.section
            return cell
        default:
            return UITableViewCell()
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
//        let vc = ViewFactory.createToursVC(with: self.preferences)
//        self.navigationController?.pushViewController(vc, animated: true)
        presenter.createCustomTour(with: selectedCategories, prices: selectedPrices, durations: selectedDurations)
    }
}

extension PreferenceBoardViewController: PreferenceOptionDelegate{
    func didSelectItemsAt(_ items: [Int], tableCell: Int?) {
        
        guard let tableCellIndex = tableCell else { return }
        
        if tableCellIndex == 1 {
            selectedDurations = items
        } else if tableCellIndex == 2 {
            selectedPrices = items
        }
    }
    
    func didSelectCategories(_ categories: [PlaceCategory]) {
        selectedCategories = categories
    }
}

extension PreferenceBoardViewController: PreferenceBoardViewProtocol{
    func showCustomTour(_ tour: Tour) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        let vc = viewControllers[viewControllers.count - 2] as? SearchViewController
        vc?.tour = tour
        
        guard let viewController = vc else {return}
        self.navigationController!.popToViewController(viewController, animated: true)
    }
}
