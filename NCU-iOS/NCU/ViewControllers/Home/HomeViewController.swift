//
//  HomeViewController.swift
//  NCU
//
//  Created by Simon Rowlands on 14/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import Cartography

final class HomeViewController: UIViewController {
    
    let welcomeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setup()
        
        if let user = User.get() {
            welcomeLabel.text = "\(user.givenName)'s Journey"
        }
    }
}

extension HomeViewController: Subviewable {
    func setupSubviews() {
        welcomeLabel.text = "Your Journey"
    }
    
    func setupStyles() {
        welcomeLabel.style(with: .title1, alignment: .center)
    }
    
    func setupHierarchy() {
        view.addSubview(welcomeLabel)
    }
    
    func setupAutoLayout() {
        constrain(welcomeLabel, view) { label, view in
            label.top == view.safeAreaLayoutGuide.topMargin + 20
            label.left == view.safeAreaLayoutGuide.leftMargin
            label.right == view.safeAreaLayoutGuide.rightMargin
        }
    }
}
