//
//  ProfileViewController.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController{
    var presenter: ProfilePresenterProtocol!
    
    @IBAction func didPressedAuth(_ sender: Any) {
        let vc = ViewFactory.createAuthVC()
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        self.setupUI()
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
}

extension ProfileViewController{
    func setupUI(){
        self.view.backgroundColor = .white
    }
    
    func setupConstraints(){
        
    }
}

extension ProfileViewController: ProfileViewProtocol{
    
}

