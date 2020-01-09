//
//  AuthViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/12/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/3
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    @IBAction func didPressedSignIn(_ sender: Any) {
        
        let loginManager = FirebaseAuthManager.shared
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        loginManager.signIn(email: email, pass: password) {[weak self] (state) in

            guard let `self` = self else { return }
            
            switch state{
            case .error:
                self.showAlert("There was an error.", completion: nil)
            case .notVerified:
                self.showAlert("Please, confirm your email", completion: nil)
            case .verified:
                let vc = AppTabBarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
