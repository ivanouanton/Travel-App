//
//  SettingsViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController{
    var presenter: SettingsPresenterProtocol!
    var options = [(title: String, options: [(subTitle: String, value: String?)])]()
    
    private lazy var settingTable: UITableView = {
        let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        let optionCell = UINib(nibName: SettingTableViewCell.nibName, bundle: nil)
        table.register(optionCell, forCellReuseIdentifier: SettingTableViewCell.reuseIdentifier)
        
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        return table
    }()
    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.getSettingsProperty()
        title = "Settings"
    }
}

extension SettingsViewController{
    func setupUI(){
        self.view.backgroundColor = .white
        self.view.addSubview(self.settingTable)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            self.settingTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.settingTable.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.settingTable.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.settingTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension SettingsViewController: SettingsViewProtocol{
    func updateTable(with options: [(title: String, options: [(subTitle: String, value: String?)])]) {
        self.options = options
        self.settingTable.reloadData()
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options[section].options.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.options[section].title.uppercased()
        label.font = UIFont(name: "AvenirNextLTPro-Demi", size: 12)
        label.textColor = UIColor(named: "silver")
        
        headerView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 32),
            label.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16)
        ])

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier, for: indexPath) as! SettingTableViewCell
        let option = self.options[indexPath.section].options[indexPath.row]
        cell.title = option.subTitle
        cell.value = option.value
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 2:
                let vc = ViewFactory.createAgreementVC(with: .termsAndConditions)
                vc.modalPresentationStyle = .fullScreen
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = ViewFactory.createAgreementVC(with: .privacyStatement)
                vc.modalPresentationStyle = .fullScreen
                
                self.navigationController?.pushViewController(vc, animated: true)
            default: break
            }
        }
        
    }
}
