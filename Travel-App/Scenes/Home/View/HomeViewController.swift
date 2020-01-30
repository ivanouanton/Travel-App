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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: SelfSizedTableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var closeSearchingButton: UIButton!
    
    var places = [PlaceData]()
    var searchingPlaces = [PlaceData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
                
        let maxHeightTable = UIScreen.main.bounds.size.height - tableView.frame.origin.y
                
        tableView.maxHeight = maxHeightTable

        self.places = PlaceManager.shared.places
        searchingPlaces = places
        
        let optionCell = UINib(nibName: PlaceTableViewCell.nibName, bundle: nil)
        tableView.register(optionCell, forCellReuseIdentifier: PlaceTableViewCell.reuseIdentifier)
        
        textView.attributedText = presenter.getAttributedDescription()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Setup UI
    
    private func setupSearchBar() {
        searchBar.barTintColor = UIColor.white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)

        let searchTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchTextField?.leftView?.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        searchTextField?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 16)
        searchTextField?.textColor = UIColor(named: "heavy")
        searchTextField?.doneAccessory = true
        
        let attributes = [
            NSAttributedString.Key.font : UIFont(name: "AvenirNextLTPro-Regular", size: 16)!
        ]

        searchTextField?.attributedPlaceholder = NSAttributedString(string: "Search", attributes:attributes)
        
        if #available(iOS 13, *) {
            searchBar.searchTextField.backgroundColor = .clear
        }
    }
    
    @IBAction func closeSearching(_ sender: Any) {
        tableView.isHidden = true
        closeSearchingButton.isHidden = true
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchingPlaces = places
        tableView.reloadData()
    }
}

extension HomeViewController: HomeViewProtocol{
    
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchingPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.reuseIdentifier, for: indexPath) as! PlaceTableViewCell
        
        cell.placeName?.text = searchingPlaces[indexPath.row].name
        cell.setupCategoryView(with: PlaceCategory(searchingPlaces[indexPath.row].categoryId)!)
        return cell
    }
}

extension HomeViewController: UITextFieldDelegate, UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty  else {
            searchingPlaces  = places
            self.tableView.reloadData()
            return
        }
        
        self.searchingPlaces = self.places.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = false
        closeSearchingButton.isHidden = false
    }
}
