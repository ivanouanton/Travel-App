//
//  AuthViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/12/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

import FacebookLogin
import Firebase
import FBSDKCoreKit

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fbLoginButton: FBLoginButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fbLoginButton.permissions = ["public_profile", "email"]
        self.fbLoginButton.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func facebookLogin(_ sender: Any) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
               
               // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                let vc = AppTabBarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                   
               })
        
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

extension AuthViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {

        if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
               
               // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                let vc = AppTabBarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                   
               })
        
           }
    }


