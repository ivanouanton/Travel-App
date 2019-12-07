//
//  ToursPresenter.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import FirebaseStorage
import FirebaseFirestore

class ToursPresenter{
    weak var view: ToursViewProtocol!
    var tours = [String:Tour]()
    
    required init(view: ToursViewProtocol) {
        self.view = view
    }
}

extension ToursPresenter: ToursPresenterProtocol{
    func getTours(){
        let db = Firestore.firestore()

        let docRef = db.collection("Tour")
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let tour = Tour(document.data())
                    self.tours[document.documentID] = tour
                }
                print(self.tours)
            }
        }
    }
}
