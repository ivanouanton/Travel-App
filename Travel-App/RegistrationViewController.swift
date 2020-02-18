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
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var agreementStateImage: UIImageView!
    @IBOutlet weak var okButton: UIButton!
    
    private var termsAndConditions: Bool = false
    private var privacyStatement: Bool = false
    private var acceptTerms: Bool = false

    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                                 password: passwordField.text!) { [weak self] (success, error) in
            guard let `self` = self else { return }
            var message: String = ""
            if success {
                let surname = self.surnameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = self.emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines)

                signUpManager.setUserData(name: name!, surname: surname!, email: email!) { success in }
                signUpManager.saveProfileImage(self.image) { success in }
                                
                let myViewController = SuccessfulChangePassView(nibName: "SuccessfulChangePassView", bundle: nil)
                myViewController.modalPresentationStyle = .overCurrentContext
                myViewController.message = """
                Verification link
                sent to your email address
                """
                self.removeLoader()
                myViewController.completion = {
                    self.navigationController?.popViewController(animated: true)
                }
                self.present(myViewController, animated: false, completion: nil)
                
            } else {
                message = error?.localizedDescription ?? "There was an error."
                self.showAlert(message) {
                    self.removeLoader()
                }
            } 
        }
    }
    
    @IBAction func didPressedAccesptPrivacy(_ sender: Any) {
        acceptTerms = !acceptTerms
        termsAndConditions = acceptTerms
        privacyStatement = acceptTerms
        
        if acceptTerms {
            okButton.setImage(UIImage(named: "successful"), for: .normal)
        } else {
            okButton.setImage(UIImage(named: "ok-circle"), for: .normal)
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
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        
        guard let cleanedPassword = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return "" }
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters"
        }
        
        if !self.termsAndConditions || !self.privacyStatement {
            return "Check agreements!"
        }
        
        return nil
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
        acceptTerms = self.termsAndConditions && self.privacyStatement
        self.okButton.imageView?.image = acceptTerms ? UIImage(named: "successful") : UIImage(named: "ok-circle")
    }
}
