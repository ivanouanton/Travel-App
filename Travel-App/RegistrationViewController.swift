//
//  RegistrationViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/5/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameField: CustomTextField!
    @IBOutlet weak var surnameField: CustomTextField!
    @IBOutlet weak var homeAddressField: CustomTextField!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    @IBAction func didPressedSignUp(_ sender: Any) {
        let signUpManager = FirebaseAuthManager()
           if let email = emailField.text, let password = passwordField.text {
               signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                   guard let `self` = self else { return }
                   var message: String = ""
                   if (success) {
                       message = "User was sucessfully created."
                   } else {
                       message = "There was an error."
                   }
                   let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                   alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                   self.present(alertController, animated: true, completion: nil)
               }
           }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHideKeyboardOnTap()
    }
}

import UIKit
extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
