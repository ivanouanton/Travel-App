//
//  MarkerView.swift
//  Travel-App
//
//  Created by Антон Иванов on 3/22/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

enum MarkerState {
    case `default`
    case selected
    case transparent
}

class MarkerView: UIView {
    
    var state: MarkerState = .default {
        didSet {
            setupView()
        }
    }
    
    var category: PlaceCategory? {
        didSet {
            guard let _ = category else { return }
            setupCategory()
        }
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MarkerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setupView()
    }
    
    private func setupView() {
        switch state {
        case .default:
            frame.size = CGSize(width: 40, height: 40)
            bgView.layer.cornerRadius = 20
        case .selected:
            frame.size = CGSize(width: 50, height: 50)
            bgView.layer.cornerRadius = 25
        case .transparent:
            frame.size = CGSize(width: 40, height: 40)
            bgView.layer.cornerRadius = 20
        }
    }
    
    private func setupCategory() {
        bgView.layer.backgroundColor = category!.getColor().cgColor
        categoryImage.image = category!.getImage()
    }
}

extension UIView {
    
    class func nibInstance() -> Self {
        return initFromNib()
    }
    
    private class func initFromNib<T>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self),
                                        owner: nil,
                                        options: nil)?[0] as! T // swiftlint:disable:this force_cast

    }
}
