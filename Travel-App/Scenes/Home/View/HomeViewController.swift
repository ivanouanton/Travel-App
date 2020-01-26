//
//  HomeViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/19/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var places = ["Zhodino", "Minsk", "London", "Bremen", "Berlin", "Minsk", "London", "Bremen", "Berlin"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension HomeViewController: HomeViewProtocol{
    
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = places[indexPath.row]
        
        return cell!
    }
    
    
}

extension HomeViewController: UITextFieldDelegate{
    
}
