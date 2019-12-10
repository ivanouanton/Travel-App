//
//  TourInfoView.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/9/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class TourInfoView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tourTitle: UILabel!
    
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
    }
    
    private func setupUI(){
        self.contentView.addSubview(self.filterView)
        
        self.widthScrollLine = self.filterView.widthAnchor.constraint(equalToConstant: 1500)
        NSLayoutConstraint.activate([
            self.filterView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            self.filterView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            self.filterView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -56),
            self.filterView.heightAnchor.constraint(equalToConstant: 3),
            self.widthScrollLine!
        ])
    }
    
    func setupTourInfo(with places: [String], title: String){
        self.contentView.subviews.forEach({ $0.removeFromSuperview() })
        self.setupUI()
        self.tourTitle.text = title
        let count = places.count
        self.widthScrollLine?.constant = CGFloat((count) * 150)
        
        var currentX: CGFloat = 150
        addPlaceMark(with: 0, placeTitle: "Home")
        
        for place in places{
            addPlaceMark(with: currentX, placeTitle: place)
            currentX += 150
        }
    }
    
    private func addPlaceMark(with centerX: CGFloat, placeTitle: String){
        
        let markImage = UIImageView()
        markImage.image = UIImage(named: "scroll-place-mark")
        markImage.contentMode = .scaleAspectFit
        markImage.translatesAutoresizingMaskIntoConstraints = false
        
        let markLabel = UILabel()
        markLabel.text = placeTitle
        markLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
        markLabel.textColor = UIColor(named: "heavy")
        markLabel.textAlignment = .center
        markLabel.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(markImage)
        self.contentView.addSubview(markLabel)

        NSLayoutConstraint.activate([
            markImage.bottomAnchor.constraint(equalTo: self.filterView.topAnchor, constant: -1),
            markImage.centerXAnchor.constraint(equalTo: self.filterView.leadingAnchor, constant: centerX),
            markImage.heightAnchor.constraint(equalToConstant: 16),
            
            markLabel.bottomAnchor.constraint(equalTo: markImage.topAnchor, constant: -6),
            markLabel.centerXAnchor.constraint(equalTo: self.filterView.leadingAnchor, constant: centerX),
            markLabel.widthAnchor.constraint(equalToConstant: 130),
        ])
    }
}
