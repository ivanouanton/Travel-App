//
//  AgreementDelegate.swift
//  Travel-App
//
//  Created by Антон Иванов on 1/19/20.
//  Copyright © 2020 companyName. All rights reserved.
//

protocol AgreementDelegate: class {
    func agreementAccept(_ state: AgreementType, accept: Bool)
}
