//
//  HomeViewController.swift
//  NCU
//
//  Created by Simon Rowlands on 14/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import Cartography

import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    let welcomeLabel = UILabel()
    let logoutButton = UIButton(type: .custom)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setup()
        
        if let user = User.get() {
            welcomeLabel.text = "\(user.givenName)'s Journey"
        }
        
        bindLoginButton()
    }

    private func bindLoginButton() {
        logoutButton.rx.tap
            .subscribe(onNext: { _ in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.logoutGID()
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: Subviewable {
    func setupSubviews() {
        welcomeLabel.text = "Your Journey"
        logoutButton.titleLabel?.style()
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor(named: "baseColor"), for: .normal)
    }
    
    func setupStyles() {
        welcomeLabel.style(with: .title1, alignment: .center)
    }
    
    func setupHierarchy() {
        view.addSubview(welcomeLabel)
        view.addSubview(logoutButton)
    }
    
    func setupAutoLayout() {
        constrain(welcomeLabel, view) { label, view in
            label.top == view.safeAreaLayoutGuide.topMargin + 20
            label.left == view.safeAreaLayoutGuide.leftMargin
            label.right == view.safeAreaLayoutGuide.rightMargin
        }
        constrain(logoutButton, view) { logoutButton, view in
            logoutButton.right == view.safeAreaLayoutGuide.rightMargin
            logoutButton.top == view.safeAreaLayoutGuide.topMargin + 8
            logoutButton.width == 100
            logoutButton.height == 50
        }
    }
}
