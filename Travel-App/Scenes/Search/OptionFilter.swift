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
    
    private lazy var folterButtons: UIStackView = {
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
    
    
    // MARK: - Methods
    
    @objc func selectedPriceFilter(){
        print("ikdfjh")
    }
    
    @objc func selectedVisetFilter(){
        print("ikdfjh")

    }
    
    @objc func showFilter(){
        self.isShownFilter = !self.isShownFilter
    }
    
    func showFilterView(){
        self.addSubview(self.filterView)
        self.filterView.addSubview(self.folterButtons)
        
        NSLayoutConstraint.activate([
            
            self.filterView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.filterView.topAnchor.constraint(equalTo: self.filterButton.bottomAnchor),
            self.filterView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.filterView.heightAnchor.constraint(equalToConstant: 92),
            
            self.folterButtons.leftAnchor.constraint(equalTo: self.filterView.leftAnchor, constant: 24),
            self.folterButtons.topAnchor.constraint(equalTo: self.filterView.topAnchor, constant: 24),
            self.folterButtons.centerXAnchor.constraint(equalTo: self.filterView.centerXAnchor),
            self.folterButtons.centerXAnchor.constraint(equalTo: self.filterView.centerXAnchor),
            self.folterButtons.heightAnchor.constraint(equalToConstant: 44),

            ])
    }
    
    func removeFilterView(){
        self.filterView.removeFromSuperview()
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
