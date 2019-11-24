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
    var options = [(title: String, options: [String])]()
    
    private lazy var settingTable: UITableView = {
        let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
        table.dataSource = self
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
    func updateTable(with options: [(title: String, options: [String])]) {
        self.options = options
        self.settingTable.reloadData()
    }
}

extension SettingsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(options.count)
        return options.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.options[section].options.count)
        return self.options[section].options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.options[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.settingTable.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        cell.textLabel?.text = self.options[indexPath.section].options[indexPath.row]
        return cell
    }
}
