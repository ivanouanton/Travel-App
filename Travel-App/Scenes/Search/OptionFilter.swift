//
//  OptionFilter.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/15/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class OptionFilter: UIView {
    
    weak var delegate: OptionFilterDelegate?
    
    private var price = ["Free", "€", "€€"]
    private var visitOptions = ["Must visit", "Visited"]
    
    var filterButtonHeight: CGFloat = 48
        
    private var isShownFilter: Bool = false{
        didSet{
            if isShownFilter{
                self.showFilterView()
                self.delegate?.didPressedFilterButton(with: 140)
            }else{
                self.removeFilterView()
                self.delegate?.didPressedFilterButton(with: filterButtonHeight)
            }
        }
    }
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Places filter", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
        button.setTitleColor(UIColor(named: "white"), for: .normal)
        button.setBackgroundColor(color: UIColor(named: "pantone")!, forState: .normal)
        button.setBackgroundColor(color: UIColor(named: "pantone")!.withAlphaComponent(0.5), forState: .focused)
        button.addTarget(self, action: #selector(showFilter), for: .touchUpInside)
        return button
    }()
    
    private lazy var filterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "white")
        return view
    }()
    
    private lazy var priceFilterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Price", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
        button.setTitleColor(UIColor(named: "pantone"), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "silver")?.cgColor
        button.setBackgroundColor(color: UIColor(named: "white")!, forState: .normal)
        button.addTarget(self, action: #selector(selectedPriceFilter), for: .touchUpInside)
        return button
    }()
    
    private lazy var visitFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Must visit", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
        button.setTitleColor(UIColor(named: "pantone"), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "silver")?.cgColor
        button.setBackgroundColor(color: UIColor(named: "white")!, forState: .normal)
        button.addTarget(self, action: #selector(selectedVisetFilter), for: .touchUpInside)
        return button
    }()
    
    private lazy var filterButtons: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 48
        stack.addArrangedSubview(self.priceFilterButton)
        stack.addArrangedSubview(self.visitFilterButton)
        return stack
    }()
        
    private lazy var filterTable: UITableView = {
        let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        let settingsCell = UINib(nibName: OptionFilterTableViewCell.nibName, bundle: nil)
        table.register(settingsCell, forCellReuseIdentifier: OptionFilterTableViewCell.reuseIdentifier)
        table.backgroundColor = UIColor(named: "white")
        table.separatorStyle = .none
        table.layer.cornerRadius = 5
        table.layer.shadowColor = UIColor.black.cgColor
        table.layer.shadowOpacity = 0.3
        table.layer.shadowOffset = .zero
        table.layer.shadowRadius = 3
        table.layer.masksToBounds = false
        table.isScrollEnabled = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var visitTable: UITableView = {
        let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        let settingsCell = UINib(nibName: OptionFilterTableViewCell.nibName, bundle: nil)
        table.register(settingsCell, forCellReuseIdentifier: OptionFilterTableViewCell.reuseIdentifier)
        table.backgroundColor = UIColor(named: "white")
        table.separatorStyle = .none
        table.layer.cornerRadius = 5
        table.layer.shadowColor = UIColor.black.cgColor
        table.layer.shadowOpacity = 0.3
        table.layer.shadowOffset = .zero
        table.layer.shadowRadius = 3
        table.layer.masksToBounds = false
        table.isScrollEnabled = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    
    // MARK: - Methods
    
    @objc func selectedPriceFilter(){
        self.delegate?.didPressedFilterButton(with: 247)
        self.addfiterTable()
    }
    
    @objc func selectedVisetFilter(){
        self.delegate?.didPressedFilterButton(with: 190)
        self.addfiterVisitTable()
    }
    
    @objc func showFilter(){
        self.isShownFilter = !self.isShownFilter
    }
    
    func showFilterView(){
        self.addSubview(self.filterView)
        self.filterView.addSubview(self.filterButtons)
        
        NSLayoutConstraint.activate([
            
            self.filterView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.filterView.topAnchor.constraint(equalTo: self.filterButton.bottomAnchor),
            self.filterView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.filterView.heightAnchor.constraint(equalToConstant: 92),
            
            self.filterButtons.leftAnchor.constraint(equalTo: self.filterView.leftAnchor, constant: 24),
            self.filterButtons.topAnchor.constraint(equalTo: self.filterView.topAnchor, constant: 24),
            self.filterButtons.centerXAnchor.constraint(equalTo: self.filterView.centerXAnchor),
            self.filterButtons.centerXAnchor.constraint(equalTo: self.filterView.centerXAnchor),
            self.filterButtons.heightAnchor.constraint(equalToConstant: 44),
            ])
    }
    
    func removeFilterView(){
        self.filterView.removeFromSuperview()
    }
    
    func addfiterTable(){
        self.addSubview(self.filterTable)
        
        NSLayoutConstraint.activate([
            self.filterTable.leftAnchor.constraint(equalTo: priceFilterButton.leftAnchor),
            self.filterTable.topAnchor.constraint(equalTo: self.priceFilterButton.topAnchor),
            self.filterTable.widthAnchor.constraint(equalTo: self.priceFilterButton.widthAnchor),
            self.filterTable.heightAnchor.constraint(equalToConstant: 174),
        ])
    }
    
    func addfiterVisitTable(){
        self.addSubview(self.visitTable)
        
        NSLayoutConstraint.activate([
            self.visitTable.leftAnchor.constraint(equalTo: visitFilterButton.leftAnchor),
            self.visitTable.topAnchor.constraint(equalTo: self.visitFilterButton.topAnchor),
            self.visitTable.widthAnchor.constraint(equalTo: self.visitFilterButton.widthAnchor),
            self.visitTable.heightAnchor.constraint(equalToConstant: 107),
        ])
    }
    
    // MARK: - Life Cicle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI(){
        
        self.addSubview(self.filterButton)

    }
    
    private func setupConstraints(){
                
        NSLayoutConstraint.activate([
            self.filterButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.filterButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.filterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.filterButton.heightAnchor.constraint(equalToConstant: filterButtonHeight),
        ])
    }
}

extension OptionFilter: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.filterTable{
            return self.price.count
        } else if tableView == self.visitTable{
            return self.visitOptions.count
        } else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionFilterTableViewCell.reuseIdentifier, for: indexPath) as! OptionFilterTableViewCell
        
        if tableView == self.filterTable{
            cell.setupLabel(with: self.price[indexPath.row])
        }else{
            cell.setupLabel(with: self.visitOptions[indexPath.row])
            if indexPath.row == 0{
                cell.setupAsFirstRow()
            }
        }
        return cell

    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if tableView == self.filterTable{
           let view = UIView()
           let label = Label()
           label.text = "Price"
           label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 16)
           label.textColor = UIColor(named: "silver")
           label.translatesAutoresizingMaskIntoConstraints = false
           
           view.addSubview(label)
           
           NSLayoutConstraint.activate([
               label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
               label.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
               label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
           ])
            return view
            
           }else{
               let view = UIView()
               view.frame.size.height = 0
               return view
           }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame.size.height = 0
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.filterTable{
            self.filterTable.removeFromSuperview()
            self.priceFilterButton.titleLabel?.text = self.price[indexPath.row]
        }else if tableView == self.visitTable{
            self.visitTable.removeFromSuperview()
            self.visitFilterButton.titleLabel?.text = self.visitOptions[indexPath.row]
        }
        self.delegate?.didPressedFilterButton(with: self.filterView.frame.height+self.filterButton.frame.height)
    }
}
