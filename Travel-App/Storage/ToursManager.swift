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
    
    func getTours(_ completionHandler: @escaping (_ tours: [Tour]?, _ error: Error?) -> Void){
        let db = Firestore.firestore()
        var tours = [Tour]()
        let aGroup = DispatchGroup()
        var queryError: Error? = nil

        aGroup.enter()
        let docRef = db.collection("Tour")
        docRef.getDocuments() { (querySnapshot, error) in
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


