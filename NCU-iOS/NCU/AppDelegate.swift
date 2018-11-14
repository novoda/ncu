//
//  AppDelegate.swift
//  NCU
//
//  Created by Simon Rowlands on 09/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupGID()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate: GIDSignInDelegate {
    func setupGID() {
        GIDSignIn.sharedInstance().clientID = "576683323078-lr4aaiclkqf7l74kthkspcne0hc475ns.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        guard error == nil else {
            transitionWithFade(to: LoginViewController())
            return
        }
        
        let newUser = User.create(from: user)
        newUser.store()
        
        if window?.rootViewController as? SplashViewController != nil || window?.rootViewController as? LoginViewController != nil {
            if newUser.hasSeenOnboarding {
                transitionWithFade(to: HomeViewController())
                return
            } else {
                let navigationController = UINavigationController(rootViewController: OfficeSelectViewController())
                navigationController.setNavigationBarHidden(true, animated: false)
                transitionWithFade(to: navigationController)
                return
            }
        }
        
//            // Needs to validate that this is a valid novoda email/account?
              // Is this via novoda domain check or is this hibob account exists check?
//            guard user.profile.email.contains("@novoda.com") else {
//                GIDSignIn.sharedInstance()?.signOut()
//
//                let alertController = UIAlertController(title: "Error", message: "You are not using a valid Novoda account", preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "Ok", style: .default))
//
//                window?.rootViewController?.present(alertController, animated: true)
//                return
//            }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Did disconnect user : \(error.localizedDescription)")
    }
    
    func transitionWithFade(to viewController: UIViewController) {
        guard let window = window else { return }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.window?.rootViewController = viewController
        }, completion: nil)
    }
}
