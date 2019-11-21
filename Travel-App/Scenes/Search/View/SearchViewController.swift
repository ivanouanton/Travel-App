//
//  SearchViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit
import GoogleMaps

final class SearchViewController: UIViewController{
    var presenter: SearchPresenterProtocol!
    private var placePreviewBottom: NSLayoutConstraint!
    
    private lazy var placePreview: PlacePreview = {
        let place = PlacePreview()
        place.translatesAutoresizingMaskIntoConstraints = false
        place.backgroundColor = UIColor.white
        place.contentMode = .scaleAspectFill
        return place
    }()
    
    override func loadView() {
        super.loadView()
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        self.setupUI()
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New York"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let window = UIApplication.shared.keyWindow
        let safeAria = window?.safeAreaInsets.bottom
        let heightTabBar: CGFloat = (safeAria ?? 0.0) + 49
        self.placePreviewBottom.constant = -(heightTabBar + 20)
    }

}

extension SearchViewController{
    func setupUI(){
        self.view.backgroundColor = .white
        self.view.addSubview(self.placePreview)
    }
    
    func setupConstraints(){
        self.placePreviewBottom = self.placePreview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80 )
        NSLayoutConstraint.activate([
            self.placePreview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24),
            self.placePreview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.placePreviewBottom,
//            self.placePreview.heightAnchor.constraint(equalTo: self.placePreview.widthAnchor, multiplier: 0.5)
            ])
    }
    
    // MARK: - Methods
    
    @objc func doAction(){
        let blackView = UIView()
        blackView.backgroundColor = .red
        view.addSubview(blackView)
        
        blackView.frame = view.frame

    }
}

extension SearchViewController: SearchViewProtocol{
    
}
