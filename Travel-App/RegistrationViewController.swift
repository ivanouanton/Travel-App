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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameField: CustomTextField!
    @IBOutlet weak var surnameField: CustomTextField!
    @IBOutlet weak var homeAddressField: CustomTextField!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var agreementStateImage: UIImageView!
    
    private var termsAndConditions: Bool = false
    private var privacyStatement: Bool = false

    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHideKeyboardOnTap()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

        setupAvatar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func didPressedSignUp(_ sender: Any) {
        
        let error = validateFields()
        
        guard error == nil else {
            showAlert(error!, completion: nil)
            return
        }
        
        let name = self.nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.addLoader()
        let signUpManager = FirebaseAuthManager.shared
        signUpManager.createUser(name: name!,
                                 email: emailField.text!,
                                 password: passwordField.text!) { [weak self] (success) in
            guard let `self` = self else { return }
            var message: String = ""
            if success {
                let surname = self.surnameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = self.emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                let address = self.homeAddressField.text?.trimmingCharacters(in: .whitespacesAndNewlines)

                signUpManager.setUserData(name: name!, surname: surname!, email: email!, address: address! ) { success in }
                signUpManager.saveProfileImage(self.image) { success in }
                
                message = "User was sucessfully created."
            } else {
                message = "There was an error."
            }
                                    
            self.showAlert(message) {
                self.removeLoader()
                self.performSegue(withIdentifier: "signIn", sender: self)
            }
        }
    }
    
    @IBAction func didPressedTermsAndConditions(_ sender: Any) {
        let vc = ViewFactory.createAgreementVC(with: .termsAndConditions)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didPressedPrivacyStatement(_ sender: Any) {
        
        let vc = ViewFactory.createAgreementVC(with: .privacyStatement)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didPressedSighIn(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification){

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    func setupAvatar() {
        avatarImage.clipsToBounds = true
        avatarImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatarImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
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

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[.editedImage] as? UIImage {
            image = imageSelected
            avatarImage.image = imageSelected
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension RegistrationViewController: AgreementDelegate {
    func agreementAccept(_ state: AgreementType, accept: Bool) {
        switch state {
        case .termsAndConditions:
            self.termsAndConditions = accept
        case .privacyStatement:
            self.privacyStatement = accept
        }
        
        self.agreementStateImage.image = (self.termsAndConditions && self.privacyStatement) ? UIImage(named: "successful") : UIImage(named: "ok-circle")
    }
}
