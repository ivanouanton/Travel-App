//
//  ToursManager.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ToursManager {
    static let shared = ToursManager()
    private let duration = ["A Few Hours", "Half Day",  "Full Day"]
    private let transport = ["subway", "taxi",  "bus"]

    private let imagesCache = NSCache<NSString, UIImage>()

    init() {}
    
    func getImage(with reference: DocumentReference,
                  completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        
        let collectionID = reference.parent.collectionID
        let documentID = reference.documentID
                
        let db = Storage.storage().reference()
        let collectionRef = db.child(collectionID)
        let imageRef = collectionRef.child(documentID)
        
            imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    completionHandler(nil, error)
                } else {
                    let image = UIImage(data: data!)
                    completionHandler(image, nil)
                }
            }
    }
    
    func getTours(_ preferences: [Int:Int],
                  completionHandler: @escaping (_ tours: [Tour]?, _ error: Error?) -> Void){
        let db = Firestore.firestore()
        var tours = [Tour]()
        let aGroup = DispatchGroup()
        var queryError: Error? = nil

        let docRef = db.collection("Tour")
        var query = docRef.order(by: "name")

        for (key, val) in preferences{
            switch key {
            case 0:
                break
            case 1:
                query = query.whereField("duration", isEqualTo: self.duration[val])
            case 2:
                query = query.whereField("price", isEqualTo: val)
            case 3:
                query = query.whereField("transport", arrayContains: self.transport[val])
            default:
                break
            }
        }
        
        aGroup.enter()
        query.getDocuments() { (querySnapshot, error) in
            if let response = querySnapshot {
                for document in response.documents {
                    var tour = Tour(document.data())
                    if let ref = tour.imageRef{
                        aGroup.enter()
                        self.getImage(with: ref) { (image, error) in
                            tour.image = image
                            aGroup.leave()
                            tours.append(tour)
                        }
                    }
                    
                }
            }
            queryError = error
            aGroup.leave()
        }
        
        aGroup.notify(queue: DispatchQueue.main){
            completionHandler(tours, queryError)
        }
    }
}


