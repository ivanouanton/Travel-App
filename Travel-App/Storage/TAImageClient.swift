//
//  TAImageClient.swift
//  Travel-App
//
//  Created by Anton Ivanov on 4/24/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

typealias JSON = [String : Any]
fileprivate let imageCache = NSCache<NSString, UIImage>()

extension NSError {
    static func generalParsingError(domain: String) -> Error {
        return NSError(domain: domain, code: 400, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Error retrieving data", comment: "General Parsing Error Description")])
    }
}

class TAImageClient {
    
    //MARK: - Public
    
    static func downloadImage(reference: DocumentReference, completion: @escaping (_ image: Data?, _ error: Error? ) -> Void) {
        let collectionID = reference.parent.collectionID
        let documentID = reference.documentID
        
        let db = Storage.storage().reference()
        let collectionRef = db.child(collectionID)
        let imageRef = collectionRef.child(documentID)
        
        imageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(data, nil)
            }
        }
    }
    
    static func getImage(with reference: DocumentReference,
                  completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: reference.documentID as NSString) {
            completion(cachedImage, nil)
        } else {
            TAImageClient.downloadImage(reference: reference) { data, error in
                if let error = error {
                    completion(nil, error)
                    return
                    
                } else if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: reference.documentID as NSString)
                    completion(image, nil)
                } else {
                    completion(nil, NSError.generalParsingError(domain: reference.documentID))
                }
            }
        }
    }

    
    //MARK: - Private
    fileprivate static func downloadData(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession(configuration: .ephemeral).dataTask(with: URLRequest(url: url)) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    fileprivate static func convertToJSON(with data: Data) -> JSON? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON
        } catch {
            return nil
        }
    }
}
