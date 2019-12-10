//
//  TourInfoView.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/9/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class TourInfoView: UIView {
    
    var tour: Tour? {
            didSet{
                guard let tour = tour else {return}
                self.setupPlacesScroll(tour)
            }
        }
    
    @IBOutlet weak var contentView: UIView!
    
    private lazy var filterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "smokyTopaz")
        return view
    }()
    
    var widthScrollLine: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
        self.setupConstraints()
    }
    
    private func setupUI(){
        self.contentView.addSubview(self.filterView)
    }
    
    private func setupConstraints(){
        self.widthScrollLine = self.filterView.widthAnchor.constraint(equalToConstant: 1500)
        NSLayoutConstraint.activate([
            self.filterView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.filterView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.filterView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.filterView.heightAnchor.constraint(equalToConstant: 3),
            self.widthScrollLine!
        ])
    }
    
    private func setupPlacesScroll(_ tour: Tour){
        let count = tour.place.count
        self.widthScrollLine?.constant = CGFloat((count) * 100)
        
        var currentX: CGFloat = 0
        
        for place in tour.place{
            addPlaceMark(with: currentX)
            currentX += 100
        }
    }
    
    
    private func addPlaceMark(with centerX: CGFloat){
        
        let markImage = UIImageView()
        markImage.image = UIImage(named: "scroll-place-mark")
        markImage.contentMode = .scaleAspectFit
        markImage.translatesAutoresizingMaskIntoConstraints = false
        
        let markLabel = UILabel()
        markLabel.text = "Home & home"
        markLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
        markLabel.textColor = UIColor(named: "pantone")
        markLabel.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(markImage)
        self.contentView.addSubview(markLabel)

        NSLayoutConstraint.activate([
            markImage.bottomAnchor.constraint(equalTo: self.filterView.topAnchor, constant: -1),
            markImage.centerXAnchor.constraint(equalTo: self.filterView.leadingAnchor, constant: centerX),
            markImage.heightAnchor.constraint(equalToConstant: 16),
            
            markLabel.bottomAnchor.constraint(equalTo: markImage.topAnchor, constant: -6),
            markLabel.centerXAnchor.constraint(equalTo: self.filterView.leadingAnchor, constant: centerX),
            markLabel.widthAnchor.constraint(equalToConstant: 80),
        ])
    }
}
