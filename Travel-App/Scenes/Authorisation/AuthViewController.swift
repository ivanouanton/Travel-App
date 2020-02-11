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
import GoogleSignIn

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fbLoginButton: FBLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fbLoginButton.permissions = ["public_profile", "email"]
        self.fbLoginButton.delegate = self
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
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
    
    @IBAction func forgotPassword(_ sender: Any) {
        let myViewController = emailModalView(nibName: "emailModalView", bundle: nil)
        myViewController.modalPresentationStyle = .overCurrentContext
        
        self.present(myViewController, animated: false, completion: nil)
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
                let signUpManager = FirebaseAuthManager.shared
                signUpManager.uid = user?.user.uid
                UserDefaultsService.shared.saveData(true, keyValue: .isLoggedIn)
                UserDefaultsService.shared.saveData(user?.user.uid, keyValue: .uid)
                self.fetchUserData()
                let vc = AppTabBarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                   
               })
        
           }
    
    private func fetchUserData() {
        
        let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, first_name, last_name, picture.width(480).height(480)"])
        graphRequest.start(completionHandler: { (connection, result, error) in
            if error != nil {
                print("Error",error!.localizedDescription)
            }
            else{
                let signUpManager = FirebaseAuthManager.shared
                let field = result! as? [String:Any]
                let firstName = field!["first_name"] as? String
                let lastName = field!["last_name"] as? String
                let email = field!["email"] as? String
                signUpManager.setUserData(name: firstName ?? "",
                                          surname: lastName ?? "",
                                          email: email ?? "") { success in }
                
                if let imageURL = ((field!["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                    print(imageURL)
                    let url = URL(string: imageURL)
                    let data = NSData(contentsOf: url!)
                    let image = UIImage(data: data! as Data)
                    signUpManager.saveProfileImage(image) { success in }
                }
            }
        })
    }
    
}

extension AuthViewController: GIDSignInDelegate {

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if let error = error {
            print(error.localizedDescription)
          return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential, completion: { (firebaseUser, error) in
         if let error = error {
             print("Login error: \(error.localizedDescription)")
             let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
             let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             alertController.addAction(okayAction)
             self.present(alertController, animated: true, completion: nil)
             return
         }
            
        let signUpManager = FirebaseAuthManager.shared
        signUpManager.uid = firebaseUser!.user.uid
        UserDefaultsService.shared.saveData(true, keyValue: .isLoggedIn)
        UserDefaultsService.shared.saveData(firebaseUser!.user.uid, keyValue: .uid)
            
        signUpManager.setUserData(name: user.profile.givenName,
                                  surname: user.profile.familyName,
                                  email: user.profile.email) { success in }
            
        let imageUrl = user.profile.imageURL(withDimension: 400)
        let data = NSData(contentsOf: imageUrl!)
        let image = UIImage(data: data! as Data)
        signUpManager.saveProfileImage(image) { success in }
            
         let vc = AppTabBarController()
         vc.modalPresentationStyle = .fullScreen
         self.present(vc, animated: true, completion: nil)
        })
        
    }
}


