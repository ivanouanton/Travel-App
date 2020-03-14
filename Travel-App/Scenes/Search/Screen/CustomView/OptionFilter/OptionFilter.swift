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
        button.setTitle("Filter places", for: .normal)
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
    
    // MARK: - Filter buttons
    
    private lazy var priceFilterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Price", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
        button.setTitleColor(UIColor(named: "pantone"), for: .normal)
        button.addTarget(self, action: #selector(selectedPriceFilter), for: .touchUpInside)
        return button
    }()
    
    private lazy var visitedFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Visited", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
        button.setTitleColor(UIColor(named: "pantone"), for: .normal)
        button.addTarget(self, action: #selector(selectedVisetedFilter), for: .touchUpInside)
        return button
    }()
    
    private lazy var mustVisitFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Must visit", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
        button.setTitleColor(UIColor(named: "pantone"), for: .normal)
        button.addTarget(self, action: #selector(selectedMustVisitFilter), for: .touchUpInside)
        return button
    }()
    
    private var removeMustVisitFilterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)
        return button
    }()
    
    private lazy var removeVisitedFilterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)
        return button
    }()
    
    private lazy var removePriceFilterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)
        return button
    }()
    
    private lazy var mustVisitStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.addBorderView()
        stack.addArrangedSubview(self.mustVisitFilterButton)
        stack.addArrangedSubview(self.removeMustVisitFilterButton)
        return stack
    }()
    
    private lazy var visitedStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.addBorderView()
        stack.addArrangedSubview(self.visitedFilterButton)
        stack.addArrangedSubview(self.removeVisitedFilterButton)
        return stack
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.addBorderView()
        stack.addArrangedSubview(self.priceFilterButton)
        stack.addArrangedSubview(self.removePriceFilterButton)
        return stack
    }()
    
    private lazy var filterButtons: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        stack.addArrangedSubview(self.priceStackView)
        stack.addArrangedSubview(self.visitedStackView)
        stack.addArrangedSubview(self.mustVisitStackView)
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

    // MARK: - Methods
    
    @objc func removeFilter(){
        self.delegate?.didPressedFilterButton(with: 247)
        delegate?.didDeselect(with: OptionFilterSelection.mustVisit)
        
        let buttons = [visitedFilterButton, mustVisitFilterButton, priceFilterButton]
        let removeButtons = [removePriceFilterButton, removeMustVisitFilterButton, removeVisitedFilterButton]
        
        buttons.forEach { (button) in
            button.isUserInteractionEnabled = true
            button.setTitleColor(UIColor(named: "pantone"), for: .normal)
        }
        
        removeButtons.forEach { (button) in
            button.isHidden = true
        }
    }
    
    @objc func selectedPriceFilter(){
        removeFilter()
        self.delegate?.didPressedFilterButton(with: 247)
        self.filterButton.setTitle("Filter by: Price", for: .normal)
        self.addfiterTable()
        removePriceFilterButton.isHidden = false
        priceFilterButton.setTitleColor(UIColor(named: "silver"), for: .normal)
    }
    
    @objc func selectedVisetedFilter(){
        removeFilter()
        self.delegate?.didPressedFilterButton(with: 190)
        self.filterButton.setTitle("Filter by: Visited", for: .normal)
         self.delegate?.didSelected(with: .visited)
        removeVisitedFilterButton.isHidden = false
        visitedFilterButton.isUserInteractionEnabled = false
        visitedFilterButton.setTitleColor(UIColor(named: "silver"), for: .normal)
    }
    
    @objc func selectedMustVisitFilter(){
        removeFilter()
        self.delegate?.didPressedFilterButton(with: 190)
        self.filterButton.setTitle("Filter by: Must visit", for: .normal)
        self.delegate?.didSelected(with: .mustVisit)
        removeMustVisitFilterButton.isHidden = false
        mustVisitFilterButton.isUserInteractionEnabled = false
        mustVisitFilterButton.setTitleColor(UIColor(named: "silver"), for: .normal)
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
            
            self.filterButtons.leftAnchor.constraint(equalTo: self.filterView.leftAnchor, constant: 12),
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
        return self.price.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionFilterTableViewCell.reuseIdentifier, for: indexPath) as! OptionFilterTableViewCell
        cell.setupLabel(with: self.price[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

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
        self.filterTable.removeFromSuperview()
        self.priceFilterButton.titleLabel?.text = self.price[indexPath.row]
        self.delegate?.didPressedFilterButton(with: self.filterView.frame.height+self.filterButton.frame.height)
        self.delegate?.didSelected(with: .price(indexPath.row))
    }
}

private extension UIStackView {
    func addBorderView() {
        let subView = UIView(frame: bounds)
        subView.layer.cornerRadius = 5
        subView.layer.borderWidth = 1
        subView.layer.borderColor = UIColor(named: "silver")?.cgColor
        subView.backgroundColor = .clear
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
