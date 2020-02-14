//
//  FirebaseProfileManager.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/7/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import Firebase
import FirebaseStorage
import UIKit

class FirebaseProfileManager {
    
    static let shared = FirebaseProfileManager()

    private init() {}
    
    private var userDocumentId: String = ""
    var placesId = [String]()
    
    
    func updateUserPlaces(_ places: [String], _ completion: @escaping (_ success: Bool, _ error: Error?) -> Void){
        placesId = places
        let db = Firestore.firestore()
        db.collection("users").document(userDocumentId).updateData(["places" : places]) { (error) in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
                completion(false, error)
            } else {
                print("Document successfully updated")
                completion(true, error)
            }
        }
    }
    
    func getAuthUserData(_ completion: @escaping (_ user: UserProfile?, _ image: UIImage?, _ error: Error?) -> Void){
        
        let db = Firestore.firestore()
        
        let uidUser = UserDefaultsService.shared.getData(for: .uid) as? String
        guard let uid = uidUser else {
            completion(nil, nil, nil)
            return
        }

        let docRef = db.collection("users")
        let query = docRef.whereField("uid", isEqualTo: uid)
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(nil, nil, err)
                print("Error getting documents: \(err)")
            } else {
                
                guard let userData = querySnapshot!.documents.first else {
                    completion(nil, nil, nil)
                    return
                }
                self.userDocumentId = userData.documentID
                let user = UserProfile(userData.data())
                self.placesId = user.places ?? []

                // MARK: Getting image profile
                
                let storageRef = Storage.storage().reference(forURL: "gs://trello-2704d.appspot.com")
                let storageProfileRef = storageRef.child("profile").child(uid)
                
                storageProfileRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        completion(user, nil, error)
                    } else {
                        let image = UIImage(data: data!)
                        completion(user, image, nil)
                    }
                }
            }
        }
    }
    
}
