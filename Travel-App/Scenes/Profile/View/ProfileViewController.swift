//
//  ProfileViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController{
    var presenter: ProfilePresenterProtocol!
    
    @IBAction func didPressedAuth(_ sender: Any) {
        let vc = ViewFactory.createAuthVC()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var profileTableView: UITableView!
    
    private var tableSection = ["Information", "Recent places"]
    private var information: [(key: String, value: String)] = [("Language", "English"), ("Home address", "352 Thiel Motorway Suite 421")]
    
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        self.setupUI()
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let optionCell = UINib(nibName: ProfileOptionViewCell.nibName, bundle: nil)
        self.profileTableView.register(optionCell, forCellReuseIdentifier: ProfileOptionViewCell.reuseIdentifier)
        let recentPlacesCell = UINib(nibName: RecentPlacesTableViewCell.nibName, bundle: nil)
        self.profileTableView.register(recentPlacesCell, forCellReuseIdentifier: RecentPlacesTableViewCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
}

extension ProfileViewController{
    func setupUI(){
        self.view.backgroundColor = .white
    }
    
    func setupConstraints(){
        
    }
}

extension ProfileViewController: ProfileViewProtocol{
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.tableSection.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view =  UIView()
        view.backgroundColor = .white
        let label = UILabel()
        label.text = self.tableSection[section]
        label.font = UIFont(name: "AvenirNextLTPro-Demi", size: 24)
        label.textColor = UIColor(named: "heavy")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return self.information.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileOptionViewCell.reuseIdentifier, for: indexPath) as! ProfileOptionViewCell
            let info = self.information[indexPath.row]
            cell.setupOption(with: info.key , value: info.value)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentPlacesTableViewCell.reuseIdentifier, for: indexPath) as! RecentPlacesTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 1:
            return 234
        default:
            return tableView.rowHeight
        }
    }
    
    
}
