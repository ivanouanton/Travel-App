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
    
    private var categoriesName: [String] = ["All"]

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
    
    @objc func setupPreferences(){
        let storyboard = UIStoryboard(name: "PreferencesTour", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PreferenceBoardViewController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
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

        
        self.view.addSubview(self.categoryView)
        self.view.addSubview(self.mapView)
        self.view.addSubview(self.placePreview)
        self.view.addSubview(self.createTourButton)
    }
    
    func setupConstraints(){
        self.placePreviewBottom = self.placePreview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        self.placePreviewTop = self.placePreview.topAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            
            self.categoryView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.categoryView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.categoryView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.categoryView.heightAnchor.constraint(equalToConstant: 32),

            self.mapView.topAnchor.constraint(equalTo: self.categoryView.safeAreaLayoutGuide.bottomAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),

            self.placePreview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24),
            self.placePreview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.placePreviewTop,
            
            self.createTourButton.topAnchor.constraint(equalTo: self.categoryView.bottomAnchor, constant: 16),
            self.createTourButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
            ])
    }
    
    // MARK: - Methods
    
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
    
//    func drawPath()
//    {
//        let origin = "\(43.1561681),\(-75.8449946)"
//        let destination = "\(38.8950712),\(-77.0362758)"
//
//        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(Defaults.apiKey)"
//
//        Alamofire.request(url).responseJSON { response in
//            print(response.request!)  // original URL request
//            print(response.response!) // HTTP URL response
//            print(response.data!)     // server data
//            print(response.result)   // result of response serialization
//
//            do {
//                let json = try JSON(data: response.data!)
//                let routes = json["routes"].arrayValue
//
//                for route in routes
//                {
//                    let routeOverviewPolyline = route["overview_polyline"].dictionary
//                    let points = routeOverviewPolyline?["points"]?.stringValue
//                    let path = GMSPath.init(fromEncodedPath: points!)
//                    let polyline = GMSPolyline.init(path: path)
//                    polyline.map = self.MapView
//                }
//            }
//            catch {
//                print("ERROR: not working")
//            }
//        }
//
//    }
    

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
    
    func createRoute() {
    }
}
