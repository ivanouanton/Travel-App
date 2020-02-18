//
//  emailModalView.swift
//  modalView
//
//  Created by Anton Ivanov on 2/11/20.
//  Copyright © 2020 Anton Ivanov. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol EmailModalViewDelegate: class {
    func showSuccessfulState()
}

class emailModalView: UIViewController {

    @IBOutlet weak var eMailTextField: UITextField!
    weak var delegate: EmailModalViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func changePasswordPressed(_ sender: Any) {
        guard let email = eMailTextField.text, email != "" else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print(error.localizedDescription)
                self.showAlert(error.localizedDescription, completion: nil)
            } else {
                self.dismiss(animated: false, completion: nil)
                self.delegate?.showSuccessfulState()
                
            }
        }

    }
}
