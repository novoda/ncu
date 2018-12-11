//
//  SplashViewController.swift
//  NCU
//
//  Created by Simon Rowlands on 13/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import Cartography
import GoogleSignIn

final class SplashViewController: UIViewController, GIDSignInUIDelegate {
    
    private let imageView = UIImageView(image: UIImage(named: "appLogo"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.signInSilently()
        
        setup()
    }
}

extension SplashViewController: Subviewable {
    func setupSubviews() {
        imageView.contentMode = .scaleAspectFit
    }
    
    func setupStyles() { }
    
    func setupHierarchy() {
        view.addSubview(imageView)
    }
    
    func setupAutoLayout() {
        
        let portrait = view.frame.height > view.frame.width
        
        constrain(imageView, view) { imageView, view in // Set imageView to be half minimum screen size
            imageView.center == view.center
            imageView.width == imageView.height
            if portrait {
                imageView.width == view.width / 2
            } else {
                imageView.height == view.height / 2
            }
        }
    }
}
