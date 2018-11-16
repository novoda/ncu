//
//  User.swift
//  NCU
//
//  Created by Simon Rowlands on 13/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

import GoogleSignIn

final class User: Codable {
    let userID: String
    let idToken: String
    let fullName: String
    let givenName: String
    let familyName: String
    let email: String
    
    var office: Office?
    var crafts: [Craft] = []
    
    var hasSeenOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: userID + "_hasSeenOnboarding")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userID + "_hasSeenOnboarding")
        }
    }
    
    init(userID: String, idToken: String, fullName: String, givenName: String, familyName: String, email: String, office: Office? = nil, crafts: [Craft] = []) {
        self.userID = userID
        self.idToken = idToken
        self.fullName = fullName
        self.givenName = givenName
        self.familyName = familyName
        self.email = email
        self.office = office
    }
    
    func store() { // This is until we know what data we need/where to store
        UserDefaultsStore.store(encodableData: self, to: "userData")
    }
    
    static func get() -> User? {
        return UserDefaultsStore.retrieve(from: "userData")
    }
}

extension User {
    static func create(from googleUser: GIDGoogleUser) -> User {
        return User(userID: googleUser.userID, idToken: googleUser.authentication.idToken, fullName: googleUser.profile.name, givenName: googleUser.profile.givenName, familyName: googleUser.profile.familyName, email: googleUser.profile.email)
    }
}
