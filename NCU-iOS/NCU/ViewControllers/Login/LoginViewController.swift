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
    private let logoImageView = UIImageView(image: UIImage(named: "appLogo"))
    private let novodaTitleLabel = UILabel() // To be replaced by image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
        setup()
    }
}

extension LoginViewController: Subviewable {
    func setupSubviews() {
        loginButton.layer.cornerRadius = 8
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.contentMode = .scaleAspectFit
        
        novodaTitleLabel.text = "novoda"
        titleLabel.text = "Craftmanship University"
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        novodaTitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        logoImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    func setupStyles() {
        novodaTitleLabel.style(with: .title1, color: UIColor(named: "baseColor"), alignment: .center)
        titleLabel.style(with: .title2, alignment: .center)
    }
    
    func setupHierarchy() {
        view.addSubview(logoImageView)
        view.addSubview(novodaTitleLabel)
        view.addSubview(titleLabel)
        view.addSubview(loginButton)
    }
    
    func setupAutoLayout() {
        constrain(logoImageView, novodaTitleLabel, view) { logoImageView, novodaTitleLabel, view in
            logoImageView.right <= view.safeAreaLayoutGuide.rightMargin - 30
            logoImageView.left >= view.safeAreaLayoutGuide.leftMargin + 30
            logoImageView.height == logoImageView.width
            logoImageView.centerX == view.centerX
            logoImageView.top == view.safeAreaLayoutGuide.topMargin + 20
            logoImageView.bottom <= novodaTitleLabel.top - 20
        }
        constrain(novodaTitleLabel, titleLabel, view) { novodaTitle, title, view in
            novodaTitle.right == view.safeAreaLayoutGuide.rightMargin - 30
            novodaTitle.left == view.safeAreaLayoutGuide.leftMargin + 30
            novodaTitle.height >= 30
            novodaTitle.bottom == title.top - 50
        }
        constrain(titleLabel, loginButton, view) { titleLabel, loginButton, view in
            titleLabel.right == view.safeAreaLayoutGuide.rightMargin - 30
            titleLabel.left == view.safeAreaLayoutGuide.leftMargin + 30
            titleLabel.height >= 30
            titleLabel.bottom == loginButton.top - 50
        }
        constrain(loginButton, view) { loginButton, view in
            loginButton.centerY == view.centerY + 100
            loginButton.right == view.safeAreaLayoutGuide.rightMargin - 30
            loginButton.left == view.safeAreaLayoutGuide.leftMargin + 30
            loginButton.height >= 60
        }
    }
}
