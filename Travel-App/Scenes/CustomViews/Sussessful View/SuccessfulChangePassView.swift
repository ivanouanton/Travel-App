//
//  SuccessfulChangePassView.swift
//  Travel-App
//
//  Created by Anton Ivanov on 2/11/20.
//  Copyright © 2020 companyName. All rights reserved.
//

import UIKit

class SuccessfulChangePassView: UIViewController {

    
    @IBOutlet weak var messageLabel: UILabel!
    var message: String?
    var completion: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let messageText = message {
            messageLabel.text = messageText
        }

        // Do any additional setup after loading the view.
    }


    @IBAction func okPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        completion?()
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
