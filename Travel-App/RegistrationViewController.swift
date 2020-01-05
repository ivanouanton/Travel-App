//
//  RegistrationViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/5/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit
import FirebaseStorage

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameField: CustomTextField!
    @IBOutlet weak var surnameField: CustomTextField!
    @IBOutlet weak var homeAddressField: CustomTextField!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    @IBAction func didPressedSignUp(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }else {
            let name = self.nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let signUpManager = FirebaseAuthManager.shared
            signUpManager.createUser(name: name!,
                                     email: emailField.text!,
                                     password: passwordField.text!) { [weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    let surname = self.surnameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                    let email = self.emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                    signUpManager.setUserData(name: name!, surname: surname!, email: email!) { success in
                        
                        if success {
                            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "Ok", style: .cancel) { (alertAction) in
                                self.performSegue(withIdentifier: "signIn", sender: self)
                            }
                            alertController.addAction(alertAction)
                                
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    message = "User was sucessfully created."
                } else {
                    message = "There was an error."
                }
                                        
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHideKeyboardOnTap()
    }
    
    func validateFields() -> String? {
        if nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            surnameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            homeAddressField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        
        guard let cleanedPassword = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return "" }
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    func showError(_ message: String) {
        print(message)
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
