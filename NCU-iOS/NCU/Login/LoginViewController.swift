//
//  LoginViewController.swift
//  NCU
//
//  Created by Simon Rowlands on 09/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import GoogleSignIn

import Cartography

final class LoginViewController: UIViewController, GIDSignInUIDelegate {
    private let loginButton = GIDSignInButton()
    private let titleLabel = UILabel()
    private let novodaTitleLabel = UILabel() // To be replaced by image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.signInSilently() // Needs a pre-login splash screen to avoid showing this if already logged in
        
        setup()
    }
}

extension LoginViewController: Subviewable {
    func setupSubviews() {
        loginButton.layer.cornerRadius = 8
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        novodaTitleLabel.text = "novoda"
        titleLabel.text = "Craftmanship University"
    }
    
    func setupStyles() {
        novodaTitleLabel.style(with: .title1, color: UIColor(named: "baseColor"), alignment: .center)
        titleLabel.style(with: .title2, alignment: .center)
    }
    
    func setupHierarchy() {
        view.addSubview(loginButton)
        view.addSubview(titleLabel)
        view.addSubview(novodaTitleLabel)
    }
    
    func setupAutoLayout() {
        constrain(loginButton, view) { button, view in
            button.centerY == view.centerY + 50
            button.rightMargin == view.rightMargin - 30
            button.leftMargin == view.leftMargin + 30
            button.height >= 60
        }
        constrain(titleLabel, loginButton, view) { label, button, view in
            label.rightMargin == view.rightMargin - 30
            label.leftMargin == view.leftMargin + 30
            label.height >= 30
            label.bottom == button.top - 50
        }
        constrain(novodaTitleLabel, titleLabel, view) { novodaTitle, title, view in
            novodaTitle.rightMargin == view.rightMargin - 30
            novodaTitle.leftMargin == view.leftMargin + 30
            novodaTitle.top >= view.top + 20
            novodaTitle.bottom == title.top - 50
        }
    }
}
