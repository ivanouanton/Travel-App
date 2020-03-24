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
    var distance:Double = 0.0
    
    //My location
    var myLocation: CLLocation {
        return CLLocation(latitude: PlaceManager.shared.userLocation.latitude,
                          longitude: PlaceManager.shared.userLocation.longitude)
    }

    required init(view: PreferenceBoardViewProtocol) {
        self.view = view
    }
    
    func createCustomTour(with categories: [PlaceCategory], prices: [Int], durations: [Int]) {
        distance = 0.0
            
        PlaceManager.shared.getFilteredPlaces(with: categories, prices: prices) { (places, error) in
            
            guard let places = places else {
                self.view.showErrorAlert(with: error?.localizedDescription ?? "Error")
                return
            }
            if places.isEmpty {
                self.view.showErrorAlert(with: "No places were found by your request")
                return
            }
            
            //My location
//            let myLocation = CLLocation(latitude: PlaceManager.shared.userLocation.latitude,
//                                        longitude: PlaceManager.shared.userLocation.longitude)
            let sortPlaces = self.sortPlaces(places, from: self.myLocation)
            
            var durationPlaces = [Place]()
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
    
    func sortPlaces(_ places: [Place], from myLocation: CLLocation) -> [Place] {
        if places.isEmpty {
            return [Place]()
        }
        
        let sortPlaces = places.sorted { (place1, place2) -> Bool in

            //My buddy's location
            let location1 = CLLocation(latitude: place1.locationPlace.latitude, longitude: place1.locationPlace.longitude)
            let location2 = CLLocation(latitude: place2.locationPlace.latitude, longitude: place2.locationPlace.longitude)
            
            //Measuring my distance to my buddy's (in km)
            let distance1 = myLocation.distance(from: location1) / 1000
            let distance2 = myLocation.distance(from: location2) / 1000
            
            return distance1 < distance2
        }
        
        if places.count <= 2 {
            return sortPlaces
        } else {
            //My location
            let myLocation = CLLocation(latitude: sortPlaces[0].locationPlace.latitude,
                                        longitude: sortPlaces[0].locationPlace.longitude)
            return [sortPlaces[0]] + self.sortPlaces(Array(sortPlaces[1..<sortPlaces.count]), from: myLocation)
        }
        
    }
    
    func sortPlaces2(_ places: [Place], from myLocation: CLLocation) -> [Place] {
           if places.isEmpty {
               return [Place]()
           }
           
           var sortPlaces = places.sorted { (place1, place2) -> Bool in

               //My buddy's location
               let location1 = CLLocation(latitude: place1.locationPlace.latitude, longitude: place1.locationPlace.longitude)
               let location2 = CLLocation(latitude: place2.locationPlace.latitude, longitude: place2.locationPlace.longitude)
               
               //Measuring my distance to my buddy's (in km)
               let distance1 = myLocation.distance(from: location1) / 1000
               let distance2 = myLocation.distance(from: location2) / 1000
               
               return distance1 < distance2
           }
           
           if places.count <= 2 {
               return sortPlaces
           } else {
               
               var nextPlace: Place? = nil
               var baseLocation = CLLocation(latitude: sortPlaces[0].locationPlace.latitude,
                                             longitude: sortPlaces[0].locationPlace.longitude)
               
               for (index, place) in places.enumerated() {
                   //New base point
                   baseLocation = CLLocation(latitude: place.locationPlace.latitude,
                                             longitude: place.locationPlace.longitude)
                       
                   let newDist = self.myLocation.distance(from: baseLocation) / 1000
                   if newDist > self.distance {
                       self.distance = newDist
                       nextPlace = place
                       sortPlaces.remove(at: index)
                       break
                   }
               }
               
               if nextPlace == nil {
                   nextPlace = sortPlaces.first!
                   sortPlaces.remove(at: 0)
               }
               
               
               return [nextPlace!] + self.sortPlaces2(sortPlaces, from: baseLocation)
           }
           
       }
}
