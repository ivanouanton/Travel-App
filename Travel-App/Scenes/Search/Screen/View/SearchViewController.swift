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
    private var placePreviewTop: NSLayoutConstraint!

    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: Defaults.location.latitude,
                                              longitude: Defaults.location.longitude,
                                              zoom: 15.0)
        let view = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var placePreview: PlacePreview = {
        let place = PlacePreview()
        place.translatesAutoresizingMaskIntoConstraints = false
        place.backgroundColor = UIColor.white
        place.contentMode = .scaleAspectFill
        return place
    }()
    
    private lazy var createTourButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "create-tour"), for: .normal)
        button.addTarget(self, action: #selector(setupPreferences), for: .touchUpInside)
        return button
    }()
    
    @objc func setupPreferences(){
        let storyboard = UIStoryboard(name: "PreferencesTour", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PreferenceBoardViewController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New York"
        // Creates a marker in the center of the map.
        
        let position = CLLocationCoordinate2D(latitude: 54.09, longitude: 28.31)
        let london = GMSMarker(position: position)
        london.title = "London"
        london.icon = UIImage(named: "marker1")
        london.map = mapView
        london.title = "hello"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presenter.fetchUserLocation()
    }
}

extension SearchViewController{
    func setupUI(){
        self.view.backgroundColor = .white
        self.view.addSubview(self.mapView)
        self.view.addSubview(self.placePreview)
        self.view.addSubview(self.createTourButton)
    }
    
    func setupConstraints(){
        self.placePreviewBottom = self.placePreview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        self.placePreviewTop = self.placePreview.topAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            
            self.mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),

            self.placePreview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24),
            self.placePreview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.placePreviewTop,
            
            self.createTourButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.createTourButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
            ])
    }
    
    // MARK: - Methods
    
    private func showModalDescription() {
        
        UIView.animate(withDuration: 0.25) {
            self.placePreviewBottom.isActive = true
            self.placePreviewTop.isActive = false
            self.view.layoutIfNeeded()
        }
        
        let closeBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action:#selector(hideModalDescription))
        closeBarButtonItem.tintColor = UIColor(named: "silver")
        self.navigationItem.leftBarButtonItem  = closeBarButtonItem
    }
    
    @objc private func hideModalDescription() {
        UIView.animate(withDuration: 0.25) {
            self.placePreviewBottom.isActive = false
            self.placePreviewTop.isActive = true
            self.view.layoutIfNeeded()
        }
        
        self.navigationItem.leftBarButtonItem = nil
    }
}

extension SearchViewController: SearchViewProtocol{
    func didChangeMyLocation(_ location: Location) {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15, bearing: 0, viewingAngle: 0)
    }
}

extension SearchViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        self.showModalDescription()

        return true
    }
}
