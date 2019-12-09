//
//  SearchViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 11/17/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import Alamofire

final class SearchViewController: UIViewController{
    var presenter: SearchPresenterProtocol!
    
    private var placePreviewBottom: NSLayoutConstraint!
    private var placePreviewTop: NSLayoutConstraint!
    
    private var filterViewTop: NSLayoutConstraint?
    private var polyline: GMSPolyline?

    private var isShowing = false{
        didSet{
            self.filterViewTop?.constant = isShowing ? 0 : -48
        }
    }
    
    var tour: Tour? {
        didSet{
            guard let tour = tour else {return}
            self.presenter.getTourRoute(with: tour)
        }
    }
    
    private lazy var filterByButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "heavy")
        button.setTitle("Filter by: Popular", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
        button.addTarget(self, action: #selector(selectFilter), for: .touchUpInside)
        return button
    }()
    
    private lazy var filterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var radioButtonGroup: PVRadioButtonGroup!

    
    private lazy var radioButton: PVRadioButton = {
        let view = PVRadioButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.radioButtoncolor = UIColor(named: "heavy")!
        view.buttonTitleColor = UIColor(named: "heavy")!
        view.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Regular", size: 14)
        view.buttonTitleSize = 15
        view.buttonTitle = "Must Visit"

        return view
    }()
    
    private lazy var radioButton1: PVRadioButton = {
        let view = PVRadioButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.radioButtoncolor = UIColor(named: "heavy")!
        view.buttonTitleColor = UIColor(named: "heavy")!
        view.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Regular", size: 14)
        view.buttonTitleSize = 15
        view.buttonTitle = "Visited"
        return view
    }()
    
    private lazy var radioButton2: PVRadioButton = {
        let view = PVRadioButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.radioButtoncolor = UIColor(named: "heavy")!
        view.buttonTitleColor = UIColor(named: "heavy")!
        view.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Regular", size: 14)
        view.buttonTitleSize = 15
        view.buttonTitle = "Price"

        return view
    }()

    private lazy var categoryView: CategoryFilter = {
        let collection = CategoryFilter()
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(named: "white")
        collection.delegate = self
        return collection
     }()

    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: Defaults.location.latitude,
                                              longitude: Defaults.location.longitude,
                                              zoom: 15.0)
        let view = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view.mapStyle = try? GMSMapStyle(jsonString: Defaults.kMapStyle)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var placePreview: PlacePreview = {
        let place = PlacePreview()
        place.translatesAutoresizingMaskIntoConstraints = false
        place.backgroundColor = UIColor.white
        place.contentMode = .scaleAspectFill
        place.delegate = self
        return place
    }()
    
    private lazy var createTourButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "create-tour"), for: .normal)
        button.addTarget(self, action: #selector(setupPreferences), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle

    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New York"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //self.presenter.fetchUserLocation()
        self.presenter.getPlaces()
    }
}

extension SearchViewController{
    func setupUI(){
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "white")
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

        radioButtonGroup = PVRadioButtonGroup()
        radioButtonGroup.delegate = self
        radioButtonGroup.appendToRadioGroup(radioButtons: [radioButton, radioButton1, radioButton2])
        
        self.view.addSubview(self.categoryView)
        self.view.addSubview(self.mapView)
        self.view.addSubview(self.placePreview)
        self.view.addSubview(self.createTourButton)
        self.view.addSubview(self.filterView)
        self.view.addSubview(self.filterByButton)
        self.filterView.addSubview(self.radioButton)
        self.filterView.addSubview(self.radioButton1)
        self.filterView.addSubview(self.radioButton2)
    }
    
    func setupConstraints(){
        self.placePreviewBottom = self.placePreview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        self.placePreviewTop = self.placePreview.topAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        self.filterViewTop = self.filterView.topAnchor.constraint(equalTo: self.filterByButton.bottomAnchor, constant: -48)
        
        NSLayoutConstraint.activate([
            
            self.categoryView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.categoryView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.categoryView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.categoryView.heightAnchor.constraint(equalToConstant: 32),
            
            self.filterByButton.topAnchor.constraint(equalTo: self.categoryView.bottomAnchor),
            self.filterByButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.filterByButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.filterByButton.heightAnchor.constraint(equalToConstant: 48),
            
            self.filterViewTop!,
            self.filterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.filterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.filterView.heightAnchor.constraint(equalToConstant: 48),
            
            self.radioButton.centerYAnchor.constraint(equalTo: self.filterView.centerYAnchor),
            self.radioButton.widthAnchor.constraint(equalToConstant: 120),
            self.radioButton.leftAnchor.constraint(equalTo: self.filterView.centerXAnchor, constant: -160),
            
            self.radioButton1.centerYAnchor.constraint(equalTo: self.filterView.centerYAnchor),
            self.radioButton1.widthAnchor.constraint(equalToConstant: 100),

            self.radioButton1.leftAnchor.constraint(equalTo: self.radioButton.rightAnchor, constant: 10),
            
            self.radioButton2.centerYAnchor.constraint(equalTo: self.filterView.centerYAnchor),
            self.radioButton2.widthAnchor.constraint(equalToConstant: 100),

            self.radioButton2.leftAnchor.constraint(equalTo: self.radioButton1.rightAnchor, constant: 10),

            self.mapView.topAnchor.constraint(equalTo: self.filterByButton.bottomAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),

            self.placePreview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24),
            self.placePreview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.placePreviewTop,
            
            self.createTourButton.topAnchor.constraint(equalTo: self.filterView.bottomAnchor, constant: 16),
            self.createTourButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
            ])
    }
    
    // MARK: - Methods
        
    @objc func setupPreferences(){
        self.navigationController?.pushViewController(PreferenceBoardViewController(), animated: true)
    }
    
    @objc func selectFilter(){
        self.isShowing = !self.isShowing
    }
    
    private func showModalDescription(with id: String) {
        if self.placePreviewTop.isActive{
            showModalView()
        }
        self.presenter.showModalView(with: id)
    }
    
    private func showModalView(){
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
    func clearMarkers() {
        mapView.clear()
    }
    
    func setFilter(with categories: [String]) {
        self.categoryView.categories = categories
    }
    
    func showModal(with data: PlaceData, image: UIImage?, category: String) {
        self.placePreview.place = data
        self.placePreview.category = category

        guard let image = image else {return}
        self.placePreview.image = image
    }
    
    func drawPath(with routes: String?) {
        
        let path = GMSPath.init(fromEncodedPath: routes ?? "")
        self.polyline?.map = nil
        self.polyline = GMSPolyline(path: path)
        self.polyline?.strokeWidth = 2
        self.polyline?.strokeColor = UIColor(named: "smokyTopaz")!
        self.polyline?.map = self.mapView
    }

    func addMarker(_ id: String, place: PlaceData, markerImg: UIImage?, isActive: Bool) {
        let position = CLLocationCoordinate2D(latitude: place.locationPlace.latitude,
                                              longitude: place.locationPlace.longitude)
        let marker = GMSMarker(position: position)
        marker.icon = markerImg
        marker.opacity = isActive ? 1 : 0.2
        marker.map = mapView
        marker.title = id
    }
    
    func didChangeMyLocation(_ location: Location) {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15, bearing: 0, viewingAngle: 0)
    }
}

extension SearchViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.showModalDescription(with: marker.title ?? "")
        return true
    }
}

extension SearchViewController: CategoryFilterDelegate{
    func categoryFilter(didSelectedItemAt index: Int) {
        self.presenter.filterPlaces(with: index)
    }
}

// MARK: - Place Preview Delegate

extension SearchViewController: PlacePreviewDelegate {
    func getInfoPlace(with data: PlaceData, image: UIImage?, category: String) {
        
        let storyboard = UIStoryboard(name: "InfoStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InfoPlaceViewController") as? PlaceInfoViewController
        controller?.place = data
        if let image = image{
            controller?.image = image
        }
        controller?.category = category
        
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func createRoute(with location: GeoPoint) {
        self.presenter.getRoute(with: [location])
    }
}

extension SearchViewController: RadioButtonGroupDelegate{
    func radioButtonClicked(button: PVRadioButton) {
        print(button.titleLabel?.text ?? "")
    }
}
