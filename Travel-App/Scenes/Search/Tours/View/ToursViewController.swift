//
//  ToursViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class ToursViewController: UIViewController {

    var presenter: ToursPresenterProtocol!
    
    var tours = [Tour]()
    
    private lazy var toursTable: UITableView = {
        let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        let tourCell = UINib(nibName: TourTableViewCell.nibName, bundle: nil)
        table.register(tourCell, forCellReuseIdentifier: TourTableViewCell.reuseIdentifier)
        table.backgroundColor = UIColor(named: "white")
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
        self.setupConstraints()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.getTours()
    }
}

extension ToursViewController{
    func setupUI(){
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.toursTable)
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            self.toursTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.toursTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.toursTable.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.toursTable.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension ToursViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TourTableViewCell.reuseIdentifier, for: indexPath) as! TourTableViewCell
        cell.backgroundColor = .red
        return cell
    }
 
}

extension ToursViewController: ToursViewProtocol{
    
}
