//
//  UIViewController+Extension.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/19/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(_ message: String, completion: (() -> ())? ) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel) { (alertAction) in
            (completion ?? {})()
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addLoader() {
        let loader = Loader(frame: .zero)
        loader.tag = 1204
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(loader)
        
        loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        loader.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    }
    
    func removeLoader() {
        for subview in self.view.subviews {
            if subview.tag == 1204 {
                subview.removeFromSuperview()
                break
            }
        }
    }
    
    func playLouder() {
        for subview in self.view.subviews {
            if subview.tag == 1204 {
                guard let louder = subview as? Loader else { return }
                louder.play()
                break
            }
        }
    }
}
