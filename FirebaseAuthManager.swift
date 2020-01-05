//
//  FirebaseAuthManager.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/4/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import FirebaseAuth
import Firebase
import UIKit

class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()

    private init() {}
    
    var uid: String?
    
    func createUser(name: String, email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                self.uid = user.uid
                
                user.createProfileChangeRequest().displayName = name
                
                let changeRequest = user.createProfileChangeRequest()

                changeRequest.displayName = name
                changeRequest.commitChanges { error in
                    guard let error = error else {
                        user.sendEmailVerification { (error) in
                            guard let _ = error else {
                                return print("user email verification sent")
                            }
                        }
                        return
                    }
                    print(error.localizedDescription)
                }
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func setUserData(name: String, surname: String, email: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        
        let db = Firestore.firestore()
        db.collection("users").addDocument(data: ["name":name,
                                                  "surname":surname,
                                                  "email":email,
                                                  "uid":self.uid ?? ""]) { (error) in
                                                    if let _ = error {
                                                        completionBlock(false)
                                                    }else {
                                                        completionBlock(true)
                                                    }
        }
        
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
}
