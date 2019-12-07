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
        table.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        table.layer.masksToBounds = false
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.9
        view.layer.shadowRadius = 2.0
        return view
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = "Select Tour"
    }
}

extension ToursViewController{
    func setupUI(){
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.toursTable)
//        self.view.addSubview(self.shadowView)
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            self.toursTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.toursTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.toursTable.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            self.toursTable.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
//            self.shadowView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            self.shadowView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            self.shadowView.heightAnchor.constraint(equalToConstant: 0.5),
        ])
    }
}

extension ToursViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tours.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TourTableViewCell.reuseIdentifier, for: indexPath) as! TourTableViewCell
        cell.tour = self.tours[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TourHederView()
        let tour = tours[section]
        view.setupView(with: tour.name, duration: tour.duration)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 272
    }
 
}

extension ToursViewController: ToursViewProtocol{
    func updateContent(with tours: [Tour]){
        self.tours = tours
        self.toursTable.reloadData()
    }
    
}
