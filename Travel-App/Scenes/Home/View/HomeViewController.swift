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
    
    var placesOld = ["Zhodino", "Minsk", "London", "Bremen", "Berlin", "Minsk", "London", "Bremen", "Berlin"]
    var places = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        placesOld = places
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
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchTextField.canResignFirstResponder
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard !searchTextField.text!.isEmpty  else {
            places  = placesOld
            return true
        }
        
        places = placesOld.filter({ $0.lowercased().contains(textField.text!.lowercased())
        })
        tableView.reloadData()
        return true
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard !searchText.isEmpty  else { currentUserArray = users; return }
//
//        currentUserArray = users.filter({ user -> Bool in
//            return user.name!.lowercased().contains(searchText.lowercased())
//        })
//        usersDisplayTableView.reloadData()
//
//    }
}
