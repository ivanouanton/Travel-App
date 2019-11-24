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
//    let locationManager:CLLocationManager = CLLocationManager()

    
    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 15.0)
        let place = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        place.translatesAutoresizingMaskIntoConstraints = false
        return place
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
        
//        self.locationManager.delegate = self
//        self.locationManager.requestWhenInUseAuthorization()
        
        self.setupUI()
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New York"

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.fetchUserLocation()
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
        self.view.addSubview(self.mapView)
        self.view.addSubview(self.placePreview)
        self.view.addSubview(self.createTourButton)
    }
    
    func setupConstraints(){
        self.placePreviewBottom = self.placePreview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80 )
        NSLayoutConstraint.activate([
            
            self.mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),

            self.placePreview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24),
            self.placePreview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.placePreviewBottom,
            
            self.createTourButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.createTourButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
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
    func didChangeMyLocation(_ location: Location) {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15, bearing: 0, viewingAngle: 0)
    }
}
//
//// MARK: - CLLocationManagerDelegate
//
//extension SearchViewController: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//    
//          locationManager.startUpdatingLocation()
//    
//          mapView.isMyLocationEnabled = true
//          mapView.settings.myLocationButton = true
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//        
//             mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
//             locationManager.stopUpdatingLocation()
//        }
//    }
//}
