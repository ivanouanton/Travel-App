//
//  PreferenceBoardPresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 2/9/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import GoogleMaps


class PreferenceBoardPresenter: PreferenceBoardPresenterProtocol {
 
    weak var view: PreferenceBoardViewProtocol!

    required init(view: PreferenceBoardViewProtocol) {
        self.view = view
    }
    
    func createCustomTour(with categories: [PlaceCategory], prices: [Int], durations: [Int]) {
        PlaceManager.shared.getFilteredPlaces(with: categories, prices: prices) { (places, error) in
            
            guard let places = places else { return }
            
            let sortPlaces = places.sorted { (place1, place2) -> Bool in
                //My location
                let myLocation = CLLocation(latitude: PlaceManager.shared.userLocation.latitude,
                                            longitude: PlaceManager.shared.userLocation.longitude)

                //My buddy's location
                let location1 = CLLocation(latitude: place1.locationPlace.latitude, longitude: place1.locationPlace.longitude)
                let location2 = CLLocation(latitude: place2.locationPlace.latitude, longitude: place2.locationPlace.longitude)
                
                //Measuring my distance to my buddy's (in km)
                let distance1 = myLocation.distance(from: location1) / 1000
                let distance2 = myLocation.distance(from: location2) / 1000
                
                return distance1 < distance2
            }
            
//            for place in sortPlaces {
//                //My location
//                let myLocation = CLLocation(latitude: PlaceManager.shared.userLocation.latitude,
//                                            longitude: PlaceManager.shared.userLocation.longitude)
//
//                //My buddy's location
//                let myBuddysLocation = CLLocation(latitude: place.locationPlace.latitude, longitude: place.locationPlace.longitude)
//
//                //Measuring my distance to my buddy's (in km)
//                print(myLocation.distance(from: myBuddysLocation) / 1000)
//            }
        
            var durationPlaces = [PlaceData]()
            switch durations[0] {
            case 0:
                durationPlaces = Array(sortPlaces.prefix(5))
            case 1:
                durationPlaces = Array(sortPlaces.prefix(9))
            case 2:
                durationPlaces = Array(sortPlaces.prefix(15))
            default:
                durationPlaces = sortPlaces
            }
            
            let customTour = Tour(durationPlaces)
            self.view.showCustomTour(customTour)
            
            
        }
        
    }
}
