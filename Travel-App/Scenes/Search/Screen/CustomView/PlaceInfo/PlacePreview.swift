//
//  PlacePreview.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/19/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit
import Kingfisher

class PlacePreview: UICollectionViewCell {
    
    weak var delegate: PlacePreviewDelegate?
    
    class var reuseIdentifier: String {
        return "placePreview"
    }
    
//    var place: PlaceCardModel? {
//        didSet{
//            guard let place = place else {return}
//            self.titleLabel.text = place.name
//            self.placeTitle.text = place.category
//            self.userLocationLabel.text = place.placeName ?? ""
//            switch place.price {
//            case 0:
//                self.placePrice.text = "Free"
//            case 1:
//                self.placePrice.text = "€"
//            case 2:
//                self.placePrice.text = "€€"
//            default:
//                break
//            }
//            self.image = place.image
//            if place.isVisited {
//                self.placeImage.addBlur(0.6)
//                self.visitedIndicator.isHidden = false
//                self.visitedLabel.isHidden = false
//            }
//        }
//    }
    
    var place: Place? {
        didSet{
            guard let place = place else {return}
            self.titleLabel.text = place.name
            self.placeTitle.text = place.category.getName()
            self.userLocationLabel.text = place.address ?? "no address"
            switch place.price {
            case 0:
                self.placePrice.text = "Free"
            case 1:
                self.placePrice.text = "€"
            case 2:
                self.placePrice.text = "€€"
            default:
                break
            }

            // TODO - need refactor
            if let ref = place.image {
                TAImageClient.getImage(with: ref) { (image, error) in
                    if let image = image {
                        self.image = image
                    }
                }
            }

            if place.isVisited {
                self.placeImage.addBlur(0.6)
                self.visitedIndicator.isHidden = false
                self.visitedLabel.isHidden = false
            }
        }
    }
    
    var category: String = "" {
        didSet{
            self.placeTitle.text = category
        }
    }
    
    var isTourCreated = false {
        didSet {
            self.tourSettingsButtons.isHidden = isTourCreated ? false : true
        }
    }
    
    var image: UIImage? = UIImage(named: "preview-target-place")!{
        didSet{
            guard let newImage = image else {return}
            self.placeImage.image = newImage
        }
    }
    
    private lazy var placeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "preview-target-place")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    private lazy var visitedIndicator: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "successful")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isHidden = true
        return image
    }()
    
    private lazy var visitedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I've been there!"
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14.0)
        label.textColor = .white
        label.isHidden = true
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Marlow & Sons"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNextLTPro-Demi", size: 16.0)
        label.textColor = UIColor(named: "heavy")
        return label
    }()
    
    private lazy var directionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Directions", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
        button.setTitleColor(UIColor(named: "pantone"), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor(named: "pantone")?.withAlphaComponent(0.2).cgColor
        button.addTarget(self, action: #selector(createRoute), for: .touchUpInside)
        return button
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Info", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 14)
        button.setTitleColor(UIColor(named: "pantone"), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor(named: "pantone")?.withAlphaComponent(0.2).cgColor
        button.addTarget(self, action: #selector(getInfoPlace), for: .touchUpInside)
        return button
    }()
    
    private lazy var userLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
        81 Broadway
        Brooklyn, NY 11249
        """
        label.numberOfLines = 2
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 14)
        label.textColor = UIColor(named: "silver")
        return label
    }()
    
    private lazy var placeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cafe"
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 14)
        label.textColor = UIColor(named: "onyx")
        return label
    }()
    
    private lazy var dot: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        view.widthAnchor.constraint(equalToConstant: 4).isActive = true
        view.layer.cornerRadius = 2
        view.layer.backgroundColor =  UIColor(named: "heavy")?.cgColor
        return view
    }()
    
    private lazy var placePrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "££"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 14)
        label.textColor = UIColor(named: "silver")
        return label
    }()
    
    private lazy var placeMarks: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 5
        stack.addArrangedSubview(self.placeTitle)
        stack.addArrangedSubview(self.dot)
        stack.addArrangedSubview(self.placePrice)
        return stack
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-HeavyCn", size: 30)
        button.setTitleColor(UIColor(named: "white"), for: .normal)
        button.layer.cornerRadius = 22
        button.layer.backgroundColor = UIColor(named: "heavy")?.cgColor
        button.addTarget(self, action: #selector(didPressedAddPlace), for: .touchUpInside)
        return button
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-HeavyCn", size: 30)
        button.setTitleColor(UIColor(named: "white"), for: .normal)
        button.layer.cornerRadius = 22
        button.backgroundColor =  UIColor(named: "heavy")
        button.addTarget(self, action: #selector(didPressedRemovePlaceButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var tourSettingsButtons: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 5
        stack.isHidden = true
        stack.addArrangedSubview(self.addButton)
        stack.addArrangedSubview(self.removeButton)
        
        NSLayoutConstraint.activate([
            self.addButton.heightAnchor.constraint(equalToConstant: 44),
            self.addButton.widthAnchor.constraint(equalToConstant: 44),
            self.removeButton.heightAnchor.constraint(equalToConstant: 44),
            self.removeButton.widthAnchor.constraint(equalToConstant: 44),
        ])
        return stack
    }()
    
    
    // MARK: - Methods
    
    @objc func didPressedAddPlace() {
        self.delegate?.addPlace(with: self.place!.id!)
    }
    
    @objc func didPressedRemovePlaceButton() {
        self.delegate?.removePlace(with: self.place!.id!)
    }
    
    @objc func getInfoPlace(){
        guard let place = self.place else { return }
        self.delegate?.getInfoPlace(with: place, image: self.image, category: self.category)
    }
    
    @objc func createRoute(){
        guard let loacation = self.place?.locationPlace else {return}
        self.delegate?.createRoute(with: loacation)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(visitedLabel.frame)
    }
    
    override func prepareForReuse() {
        self.visitedIndicator.isHidden = true
        self.visitedLabel.isHidden = true
        self.placeImage.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    private func setupUI(){
        self.contentView.layer.cornerRadius = 7.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.backgroundColor = UIColor.white.cgColor

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.25
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
                
        self.addSubview(self.placeImage)
        self.addSubview(self.titleLabel)
        self.addSubview(self.directionsButton)
        self.addSubview(self.infoButton)
        self.addSubview(self.userLocationLabel)
        self.addSubview(self.placeMarks)
        self.addSubview(self.tourSettingsButtons)
        self.addSubview(self.visitedIndicator)
        self.addSubview(self.visitedLabel)

    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.placeImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.placeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.placeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.placeImage.widthAnchor.constraint(equalToConstant: 120),
            self.placeImage.heightAnchor.constraint(equalToConstant: 128),
            
            self.tourSettingsButtons.bottomAnchor.constraint(equalTo: self.placeImage.bottomAnchor, constant: -10),
            self.tourSettingsButtons.leadingAnchor.constraint(equalTo: self.placeImage.leadingAnchor, constant: 10),
            self.tourSettingsButtons.centerXAnchor.constraint(equalTo: self.placeImage.centerXAnchor),

            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            self.titleLabel.leftAnchor.constraint(equalTo: self.placeImage.rightAnchor, constant: 8),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            self.placeMarks.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 7),
            self.placeMarks.leftAnchor.constraint(equalTo: self.placeImage.rightAnchor, constant: 8),

            self.directionsButton.bottomAnchor.constraint(equalTo: self.placeImage.bottomAnchor, constant: -3),
            self.directionsButton.leftAnchor.constraint(equalTo: self.placeImage.rightAnchor, constant: 8),
            self.directionsButton.heightAnchor.constraint(equalToConstant: 35),
            self.directionsButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33),
            
            self.infoButton.bottomAnchor.constraint(equalTo: self.placeImage.bottomAnchor, constant: -3),
            self.infoButton.leftAnchor.constraint(equalTo: self.directionsButton.rightAnchor, constant: 12),
            self.infoButton.heightAnchor.constraint(equalToConstant: 35),
            self.infoButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            self.userLocationLabel.bottomAnchor.constraint(equalTo: self.infoButton.topAnchor, constant: -8),
            self.userLocationLabel.leftAnchor.constraint(equalTo: self.placeImage.rightAnchor, constant: 8),
            self.userLocationLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            self.visitedIndicator.centerYAnchor.constraint(equalTo: self.placeImage.centerYAnchor, constant: -16),
            self.visitedIndicator.centerXAnchor.constraint(equalTo: self.placeImage.centerXAnchor),
            
            self.visitedLabel.topAnchor.constraint(equalTo: self.visitedIndicator.bottomAnchor, constant: 8),
            self.visitedLabel.centerXAnchor.constraint(equalTo: self.visitedIndicator.centerXAnchor),

            ])
    }
}
