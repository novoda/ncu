//
//  Subviewable.swift
//  NCU
//
//  Created by Simon Rowlands on 12/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

@objc protocol Subviewable {
    func setupSubviews()
    func setupStyles()
    func setupHierarchy()
    func setupAutoLayout()
}

extension Subviewable {
    func setup() {
        setupSubviews()
        setupStyles()
        setupHierarchy()
        setupAutoLayout()
    }
}
