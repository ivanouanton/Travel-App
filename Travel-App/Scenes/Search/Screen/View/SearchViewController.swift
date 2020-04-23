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
    
    private var tourViewBottom: NSLayoutConstraint!
    private var tourViewTop: NSLayoutConstraint!
    
    private var filterViewHeight: NSLayoutConstraint?
    
    private var polyline: GMSPolyline?
    
    private var markers = [GMSMarker]()
    
    var tour: Tour? {
        didSet{
            guard let tour = tour else {
                self.placesCollection.isTourCreated = false
                return
            }
            self.presenter.getTourRoute(with: tour)
            showTourInfo()
            self.placesCollection.isTourCreated = true
        }
    }

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
    
    private lazy var placesCollection: PlacesCollectionView = {
        let placesView =  Bundle.main.loadNibNamed("PlacesCollectionView", owner: nil, options: nil)?.first as? PlacesCollectionView
        placesView?.translatesAutoresizingMaskIntoConstraints = false
        placesView?.delegate = self

        return placesView!
    }()
    
    private lazy var createTourButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "create-tour"), for: .normal)
        button.addTarget(self, action: #selector(setupPreferences), for: .touchUpInside)
        return button
    }()
    
    private lazy var cityInfoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "pantone")
        button.layer.cornerRadius = 3
        button.setImage(UIImage(named: "binoculars"), for: .normal)
        button.addTarget(self, action: #selector(showCityInfo), for: .touchUpInside)
        return button
    }()
    
    private lazy var tourInfoView: TourInfoView = {
        let allViewsInXibArray = Bundle.main.loadNibNamed("TourInfoView", owner: self, options: nil)
        let view = allViewsInXibArray?.first as! TourInfoView
        view.translatesAutoresizingMaskIntoConstraints = false
        view.closeHandler = self.hideTourView
        return view
    }()
    
    private lazy var filterView: OptionFilter = {
        let view = OptionFilter()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        self.filterViewHeight = view.heightAnchor.constraint(equalToConstant: view.filterButtonHeight)
        return view
    }()
    
    private lazy var backToTourButton: ButtonWithImage = {
        let button = ButtonWithImage()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundColor(color: UIColor(named: "white")!, forState: .normal)
        button.setBackgroundColor(color: UIColor(named: "white")!.withAlphaComponent(0.9), forState: .highlighted)
        button.setTitle("Show tour detail", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Regular", size: 16)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(named: "silver"), for: .normal)
        button.setImage(UIImage(named: "cell-action-icon"), for: .normal)
        
        button.layer.cornerRadius = 22
        button.shadowColor = UIColor.black
        button.shadowOffset = CGSize(width: 0, height: 0)
        button.shadowRadius = 3.0
        button.shadowOpacity = 0.4
        
        button.isHidden = true
        
        button.addTarget(self, action: #selector(returnToTour), for: .touchUpInside)
        return button
    }()
    
    private lazy var removeBtn: UIBarButtonItem = {
        let btn1 = UIButton()
        btn1.setImage(UIImage(named: "close"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(removeRoute), for: .touchUpInside)
        return UIBarButtonItem(customView: btn1)
    }()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.presenter.viewDidLoad()
//        self.presenter.fetchUserLocation()
        self.title = "Rome"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        print(cityInfoButton.frame)
//    }
    
    // MARK: - Private methods
    
    private func setDefaultSizeForMarkers() {
        markers.forEach { ($0.iconView as! MarkerView).state = .default }
    }
    
    private func select(markerId: String) {
        self.setDefaultSizeForMarkers()
        
        guard let marker = markers.first(where: {$0.title == markerId}) else { return }
        let iconView = marker.iconView as! MarkerView
        iconView.state = .selected
    }
}

extension SearchViewController{
    func setupUI(){
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "white")
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        self.view.addSubview(self.categoryView)
        self.view.addSubview(self.mapView)
        self.view.addSubview(self.createTourButton)
        self.view.addSubview(self.cityInfoButton)
        self.view.addSubview(self.filterView)
        self.view.addSubview(self.backToTourButton)
        self.view.addSubview(self.placesCollection)
        self.view.addSubview(self.tourInfoView)
    }
    
    func setupConstraints(){
        self.placePreviewBottom = self.placesCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        self.placePreviewTop = self.placesCollection.topAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        self.tourViewBottom = self.tourInfoView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        self.tourViewTop = self.tourInfoView.topAnchor.constraint(equalTo: self.view.bottomAnchor)
                
        NSLayoutConstraint.activate([
            
            self.categoryView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.categoryView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.categoryView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.categoryView.heightAnchor.constraint(equalToConstant: 32),

            self.mapView.topAnchor.constraint(equalTo: self.categoryView.bottomAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            
            self.filterView.topAnchor.constraint(equalTo: self.categoryView.bottomAnchor),
            self.filterView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.filterView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            (self.filterViewHeight ?? self.filterView.heightAnchor.constraint(equalToConstant: 0)),

            self.placesCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            self.placesCollection.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.placesCollection.heightAnchor.constraint(equalToConstant: 171),
            self.placePreviewTop,
            
            self.tourInfoView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tourInfoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tourInfoView.heightAnchor.constraint(equalToConstant: 188),
            self.tourViewTop,
            
            self.cityInfoButton.topAnchor.constraint(equalTo: self.categoryView.bottomAnchor, constant: 72),
            self.cityInfoButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.cityInfoButton.heightAnchor.constraint(equalToConstant: 42),
            self.cityInfoButton.widthAnchor.constraint(equalToConstant: 63),
            
            self.createTourButton.topAnchor.constraint(equalTo: self.categoryView.bottomAnchor, constant: 72),
            self.createTourButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            self.backToTourButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.backToTourButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 55),
            self.backToTourButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.backToTourButton.heightAnchor.constraint(equalToConstant: 44)
            
            ])
    }
    
    // MARK: - Methods
    
    @objc func removeRoute() {
        self.tour = nil
        self.polyline?.map = nil
        self.hideTourView()
        self.backToTourButton.isHidden = true
        self.navigationItem.rightBarButtonItem  = nil
    }
    
    @objc func returnToTour() {
        UIView.animate(withDuration: 0.25) {
            self.tourViewBottom.isActive = true
            self.tourViewTop.isActive = false
            self.backToTourButton.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
        
    @objc func setupPreferences(){
        self.navigationController?.pushViewController(ViewFactory.createSettingsTourVC(), animated: true)
    }
    
    @objc func showCityInfo(){
        self.navigationController?.pushViewController(ViewFactory.createSettingsTourVC(), animated: true)
    }
    
    private func showModalDescription(with id: String) {
        if self.placePreviewTop.isActive{
            showModalView()
        }
        self.presenter.showModalView(with: id)
    }
    
    private func showTourInfo() {
        if self.tourViewTop.isActive{
            showModalTourView()
        }
    }
    
    private func showModalTourView(){
        UIView.animate(withDuration: 0.25) {
            self.tourViewBottom.isActive = true
            self.tourViewTop.isActive = false
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideTourView() {
        UIView.animate(withDuration: 0.25) {
            self.tourViewBottom.isActive = false
            self.tourViewTop.isActive = true
            self.backToTourButton.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    private func showModalView(){
        UIView.animate(withDuration: 0.25) {
            self.placePreviewBottom.isActive = true
            self.placePreviewTop.isActive = false
            self.view.layoutIfNeeded()
        }
        
        let closeBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action:#selector(hideModalDescription))
//        closeBarButtonItem.tintColor = UIColor(named: "silver")
        self.navigationItem.leftBarButtonItem  = closeBarButtonItem
    }
    
    @objc private func hideModalDescription() {
        UIView.animate(withDuration: 0.25) {
            self.placePreviewBottom.isActive = false
            self.placePreviewTop.isActive = true
            self.view.layoutIfNeeded()
        }
        
        self.navigationItem.leftBarButtonItem = nil
        setDefaultSizeForMarkers()
    }
}

// MARK: - Search View Protocol

extension SearchViewController: SearchViewProtocol{
    
    func showLoader(_ isNeededShowing: Bool) {
        if isNeededShowing {
            self.addLoader()
        }else{
            self.removeLoader()
        }
    }
    
    func showLocality(locality: String) {
        self.navigationItem.title = locality
    }
    
    func showPlaceView(with index: Int) {
        showModalView()
        self.placesCollection.scrollTo(itemIndex: index)
    }
    
    func setPlacesCollection(with places: [PlaceCardModel]) {
//        self.placesCollection.places = places
    }
    
    func showPreviewPlaces(with places: [Place]) {
        self.placesCollection.places = places
    }
    
    func setupTourInfo(with places: [String], title: String) {
        self.tourInfoView.setupTourInfo(with: places, title: title)
    }
    
    func clearMarkers() {
        markers.removeAll()
        mapView.clear()
    }
    
    func setFilter(with categories: [String]) {
//        self.categoryView.categories = categories
    }
    
    func setFilter(with categories: [PlaceCategory]) {
        self.categoryView.categories = categories
    }
    
    func drawPath(with routes: String?) {
        self.navigationItem.rightBarButtonItem  = removeBtn
        
        let path = GMSPath.init(fromEncodedPath: routes ?? "")
        self.polyline?.map = nil
        self.polyline = GMSPolyline(path: path)
        self.polyline?.strokeWidth = 2
        self.polyline?.strokeColor = UIColor(named: "smokyTopaz")!
        self.polyline?.map = self.mapView
    }

    func addMarker(_ id: String, place: Place, isActive: Bool) {
        let position = CLLocationCoordinate2D(latitude: place.locationPlace.latitude,
                                              longitude: place.locationPlace.longitude)
        let marker = GMSMarker(position: position)

        marker.opacity = isActive ? 1 : 0.2
        marker.map = mapView
        marker.title = id
        let view = MarkerView()
        view.category = place.category
        marker.iconView = view
        markers.append(marker)
    }
    
    func didChangeMyLocation(_ location: Location) {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15, bearing: 0, viewingAngle: 0)
    }
}

// MARK: - GMSMap Delegate

extension SearchViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.select(markerId: marker.title ?? "")
        self.showModalDescription(with: marker.title ?? "")
        return true
    }
}

// MARK: - Category Filter Delegate

extension SearchViewController: CategoryFilterDelegate{
    func didSelectItem(with category: PlaceCategory?) {
        self.presenter.filter(with: category)
    }
}

// MARK: - Place Preview Delegate

extension SearchViewController: PlacePreviewDelegate {
    func didSelect(with place: Place) {
        self.didChangeMyLocation(Location(latitude: place.locationPlace.latitude,
                                          longitude: place.locationPlace.longitude))
        
        self.select(markerId: place.id ?? "")
    }
    
    func addPlace(with id: String) {
        guard var newTour = self.tour else { return }
        for currId in newTour.place {
            if currId == id {
                self.showAlert("This point is already on the route", completion: nil)
                return
            }
        }
        newTour.place.append(id)
        self.tour = newTour
    }
    
    func removePlace(with id: String) {
        guard var newTour = self.tour else { return }
        for (ind, currId) in newTour.place.enumerated() {
            if currId == id {
                newTour.place.remove(at: ind)
                self.tour = newTour
                return
            }
        }
        self.showAlert("The tour doesn't contain this point", completion: nil)
    }
    
    func didSelect(with place: PlaceCardModel) {
        guard let location = place.location else { return }
        self.didChangeMyLocation(Location(latitude: location.latitude,
                                          longitude: location.longitude))
        self.select(markerId: place.id)
    }
    
    func getInfoPlace(with data: Place, image: UIImage?, category: String) {
    
        let controller = ViewFactory.createPlaceInfoVC()
        controller.place = data
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func createRoute(with location: GeoPoint) {
        self.presenter.getRoute(with: [location])
        self.tour = nil
        self.placesCollection.isTourCreated = false
    }
}

// MARK: - OptionFilter Delegate

extension SearchViewController: OptionFilterDelegate{
    func didDeselect(with option: OptionFilterSelection) {
        self.presenter.deselect(with: option)
    }
    
    func didSelected(with option: OptionFilterSelection) {
        self.presenter.getPlaces(with: option)
    }
    
    func didPressedFilterButton(with activeFilterHeight: CGFloat) {
        self.filterViewHeight?.constant = activeFilterHeight
    }
}
