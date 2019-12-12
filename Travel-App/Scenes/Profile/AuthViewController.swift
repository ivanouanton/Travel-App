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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 2)
        // Do any additional setup after loading the view.
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
