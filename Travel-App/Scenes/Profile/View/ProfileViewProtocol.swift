//
//  ProfileViewProtocol.swift
//  Travel-App
//
//  Created by Антон Иванов on 12/7/19.
//  Copyright © 2019 companyName. All rights reserved.
//

import UIKit

protocol ProfileViewProtocol: class{
    func showUserImage(_ image: UIImage)
    func showUserData(with name: String, information: [(key: String, value: String)])
}
