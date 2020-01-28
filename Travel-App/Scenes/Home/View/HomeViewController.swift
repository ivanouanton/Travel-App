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
    
    var places = [PlaceData]()
    var searchingPlaces = [PlaceData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.places = PlaceManager.shared.places
        searchingPlaces = places
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
        searchingPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = searchingPlaces[indexPath.row].name
        
        return cell!
    }
}

extension HomeViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.tableView.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.tableView.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let substring = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        
        guard !substring.isEmpty  else {
            searchingPlaces  = places
            self.tableView.reloadData()
            return true
        }
        
        self.searchingPlaces = self.places.filter { $0.name.lowercased().contains(substring.lowercased()) }
        self.tableView.reloadData()
        
        return true
    }
}
